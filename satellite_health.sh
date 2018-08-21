#!/bin/bash

# Script to check Satellite Health

# Date ....: Aug-21-2018
# Dev .....: Waldirio M Pinheiro <waldirio@redhat.com>/<waldirio@gmail.com>
# Purpose .: Satellite Health Check
#		- Certificates
#		- Services as Postgres, MongoDB and Squid
#
# 	     Note. You can or not enable DEBUG "cute"
#
# Usage ..: Just copy to your Satellite server and execute it "./satellite_health.sh" 
#

server=$(hostname -f)
#DEBUG=true
DEBUG=false

test_print()
{
  name=$1
  status=$2
  url_port=$3
  long_status=$4
  
  printf "%-40s%-7s%-40s%-30s\n" "$name" "$status" "$url_port" "$long_status"
}

test_ca_validation()
{
  #test_ca_validation "$name" $cert $server 443
  name=$1
  cacert=$2
  url=$3
  port=$4

  if [ $DEBUG == "true" ]; then
    echo "Name ...: $name"
    echo "CACert .: $cacert"
    echo "Url ....: $url"
    echo "Port ...: $port"
    curl -v --cacert $cacert https://$url:$port
  else
    curl -v --cacert $cacert https://$url:$port 1>/dev/null 2>/dev/null
  fi
  
  if [ $? -eq 0 ]; then
    test_print "$name" OK $url:$port "CA is OK accessing https://$server"
  else
    test_print "$name" FAIL $url:$port "CA FAIL accessing https://$server"
  fi
}

test_validation()
{
  name=$1
  cert=$2
  key=$3
  url=$4
  port=$5

  if [ $DEBUG == "true" ]; then
    echo "Name ...: $name"
    echo "Cert ...: $cert"
    echo "Key ....: $key"
    echo "Url ....: $url"
    echo "Port ...: $port"
    curl --cert $cert --key $key -k https://$url:$port
  else
    curl --cert $cert --key $key -k https://$url:$port 1>/dev/null 2>/dev/null
  fi
  
  
  if [ $? -eq 0 ]; then
    test_print "$name" OK $url:$port "Responsive"
  else
    test_print "$name" FAIL $url:$port "Non Responsive"
  fi
}

test_pulp_ca()
{
#OK
  name="PULP CA"
  cert="/etc/pki/pulp/ca.crt"
  key=$(echo $cert | sed -e 's/.crt/.key/g')

  md5_key=$(openssl rsa -noout -modulus -in /etc/pki/pulp/ca.key | md5sum | awk '{print $1}')
  md5_crt=$(openssl x509 -noout -modulus -in /etc/pki/pulp/ca.crt | md5sum | awk '{print $1}')

  if [ $DEBUG == "true" ]; then
    echo "Name ...: $name"
    echo "Cert ...: $cert"
    echo "Key ....: $key"
    echo "MD5 Key : $md5_key"
    echo "MD5 Crt : $md5_crt"
  fi
  

  if [ "$md5_key" == "$md5_crt" ]; then
    test_print "$name" OK "-" "MD5 Hash from pulp/ca.key and pulp/ca.key match"
  else
    test_print "$name" FAIL "-" "MD5 Hash from pulp/ca.key and pulp/ca.key doesn't match"
  fi

}

test_pulp_client()
{
# FIXME LATER
# https://community.theforeman.org/t/convert-from-puppet3-to-puppet4-ssl-errors-tlsv1-alert-unknown-ca/8776
# node.rb
  name="PULP CLIENT"
  cert="/etc/pki/katello/certs/pulp-client.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_katello_default_ca()
{
#OK
  name="KATELLO DEFAULT CA"
  cert="/etc/pki/katello/certs/katello-default-ca.crt"
  #key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_ca_validation "$name" $cert $server 443
}

test_katello_default_ca_stripped()
{
#OK
  name="KATELLO DEFAULT CA STRIPPED"
  cert="/etc/pki/katello/certs/katello-default-ca-stripped.crt"
  #key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_ca_validation "$name" $cert $server 443
}

test_katello_server_ca()
{
#OK
# openssl s_client -cert katello-apache.crt  -CAfile katello-server-ca.crt -key ../private/katello-apache.key -showcerts -connect  $(hostname -f):443
# openssl verify -CAfile katello-server-ca.crt  katello-apache.crt
  name="KATELLO SERVER CA and KATELLO APACHE"
  katello_server_ca_cert="/etc/pki/katello/certs/katello-server-ca.crt"
  katello_apache_cert="/etc/pki/katello/certs/katello-apache.crt"
  #key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  if [ $DEBUG == "true" ]; then
    echo "Name ...: $name"
    echo "ServerCA: $katello_server_ca_cert"
    echo "Apache .: $katello_apache_cert"
  fi
  
  verify_result=$(openssl verify -CAfile $katello_server_ca_cert $katello_apache_cert)

  if [ $? -eq 0 ]; then
    test_print "$name" OK "-" "Verify Response: $verify_result"
  else
    test_print "$name" FAIL "-" "Verify Response: $verify_result"
  fi
}

test_qpid_broker()
{
#OK
  name="QPID BROKER"
  cert="/etc/pki/katello/certs/$(hostname -f)-qpid-broker.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key localhost 5671
}

test_katello_tomcat()
{
#OK
  name="TOMCAT"
  cert="/etc/pki/katello/certs/katello-tomcat.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_java_client()
{
#OK
# qpid-config --ssl-certificate /etc/pki/katello/certs/java-client.crt --ssl-key /etc/pki/katello/private/java-client.key -b  "amqps://localhost:5671"
# curl --cert ./java-client.crt --key ../private/java-client.key https://localhost:5671 
  name="JAVA CLIENT"
  cert="/etc/pki/katello/certs/java-client.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key localhost 5671
}

test_puppet_client()
{
# AGAIN !!! 
  name="PUPPET CLIENT"
  cert="/etc/pki/katello/puppet/puppet_client.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_puppet_client_ca()
{
# AGAIN !!!
  name="PUPPET CLIENT CA"
  cert="/etc/pki/katello/puppet/puppet_client_ca.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_qpid_router_client()
{
#OK
  name="QPID ROUTER CLIENT"
  cert="/etc/pki/katello/qpid_router_client.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key localhost 5671
}

test_qpid_router_server()
{
#OK
  name="QPID ROUTER SERVER"
  cert="/etc/pki/katello/qpid_router_server.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key localhost 5671
}

test_qpid_client_striped()
{
#OK
  name="QPID CLIENT STRIPED"
  cert="/etc/pki/katello/qpid_client_striped.crt"
  url="localhost"
  port="5671"

  if [ $DEBUG == "true" ]; then
    echo "Name ...: $name"
    echo "Cert ...: $cert"
    echo "Url ....: $url"
    echo "Port ...: $port"
    curl -v --cert $cert https://$url:$port
  else
    curl -v --cert $cert https://$url:$port 1>/dev/null 2>/dev/null
  fi
  
  
  if [ $? -eq 0 ]; then
    test_print "$name" OK $url:$port "Responsive"
  else
    test_print "$name" FAIL $url:$port "Non Responsive"
  fi
}

test_candlepin-redhat-ca()
{
# LATER
  name="CANDLEPIN REDHAT CA"
  cert="/etc/candlepin/certs/upstream/candlepin-redhat-ca.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_squid()
{
  #set -x
  url=$1
  port=$2
  name="SQUID"

  if [ $DEBUG == "true" ]; then
    echo "Url ....: $url"
    echo "Port ...: $port"
    curl $url:$port
  else
    curl $url:$port 1>/dev/null 2>/dev/null
  fi

  if [ $? -eq 0 ]; then
    test_print "$name" OK $url:$port "Responsive"
  else
    test_print "$name" FAIL $url:$port "Non Responsive"
  fi
}

test_mongodb()
{
  url=$1
  port=$2
  name="MONGODB"

  if [ $DEBUG == "true" ]; then
    echo "Url ....: $url"
    echo "Port ...: $port"
cat << EOF | mongo
use pulp_database
EOF
  else
cat << EOF | mongo 1>/dev/null 2>/dev/null
use pulp_database
EOF
  fi

  if [ $? -eq 0 ]; then
    test_print "$name" OK $url:$port "Responsive"
  else
    test_print "$name" FAIL $url:$port "Non Responsive"
  fi
}

test_postgres()
{
  url=$1
  port=$2
  name="POSTGRES"

  if [ $DEBUG == "true" ]; then
    echo "Url ....: $url"
    echo "Port ...: $port"
    (echo "\conninfo") | su - postgres -c "psql foreman"
  else
    (echo "\conninfo") | su - postgres -c "psql foreman" 1>/dev/null 2>/dev/null
  fi

  if [ $? -eq 0 ]; then
    test_print "$name" OK $url:$port "Responsive"
  else
    test_print "$name" FAIL $url:$port "Non Responsive"
  fi
}







## Services
test_pulp_ca				#OK
test_katello_default_ca		#OK
test_katello_default_ca_stripped	#OK
test_katello_server_ca			#OK
test_qpid_broker			#OK
test_katello_tomcat			#OK
test_java_client			#OK
test_qpid_router_client		#OK
test_qpid_router_server		#OK
test_qpid_client_striped		#OK

## DataBase and More
test_postgres localhost 5432		#OK
test_mongodb localhost 27017		#OK
test_squid localhost 3128		#OK

# Pending Check
#test_pulp_client			#CHECK LATER
#test_puppet_client			#CHECK LATER
#test_puppet_client_ca			#CHECK LATER
#test_candlepin-redhat-ca		#CHECK LATER

