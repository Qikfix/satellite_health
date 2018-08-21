#!/bin/bash

# Script to check Satellite Health

server=$(hostname -f)
#DEBUG=true
DEBUG=false

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
    echo  "$name ................................. OK   == $url:$port Responsive"
  else
    echo  "$name ................................. FAIL == $url:$port Non Responsive"
  fi
  
}

test_pulp_ca()
{
  name="PULP CA"
  cert="/etc/pki/pulp/ca.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_pulp_client()
{
  name="PULP CLIENT"
  cert="/etc/pki/katello/certs/pulp-client.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_katello_default_ca()
{
  name="KATELLO DEFAULT CA"
  cert="/etc/pki/katello/certs/katello-default-ca.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_katello_default_ca_stripped()
{
  name="KATELLO DEFAULT CA STRIPPED"
  cert="/etc/pki/katello/certs/katello-default-ca-stripped.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_katello_server_ca()
{
  name="KATELLO SERVER CA"
  cert="/etc/pki/katello/certs/katello-server-ca.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_katello_apache()
{
  name="KATELLO APACHE"
  cert="/etc/pki/katello/certs/katello-apache.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
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
  name="JAVA CLIENT"
  cert="/etc/pki/katello/certs/java-client.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_puppet_client()
{
  name="PUPPET CLIENT"
  cert="/etc/pki/katello/puppet/puppet_client.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_puppet_client_ca()
{
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
  name="QPID CLIENT STRIPED"
  cert="/etc/pki/katello/qpid_client_striped.crt"
  key=$(echo $cert | sed -e 's/certs/private/g' -e 's/.crt/.key/g')

  test_validation "$name" $cert $key $server 8443
}

test_candlepin-redhat-ca()
{
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

  if [ $DEBUG == "true" ]; then
    echo "Url ....: $url"
    echo "Port ...: $port"
    curl $url:$port
  else
    curl $url:$port 1>/dev/null 2>/dev/null
  fi

  if [ $? -eq 0 ]; then
    echo  "SQUID ................................. OK   == $url:$port Responsive"
  else
    echo  "SQUID ................................. FAIL == $url:$port Non Responsive"
  fi
}

test_mongodb()
{
  url=$1
  port=$2

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
    echo  "MONGODB ............................... OK   == $url:$port Responsive"
  else
    echo  "MONGODB ............................... FAIL == $url:$port Non Responsive"
  fi
}

test_postgres()
{
  url=$1
  port=$2

  if [ $DEBUG == "true" ]; then
    echo "Url ....: $url"
    echo "Port ...: $port"
    (echo "\conninfo") | su - postgres -c "psql foreman"
  else
    (echo "\conninfo") | su - postgres -c "psql foreman" 1>/dev/null 2>/dev/null
  fi

  if [ $? -eq 0 ]; then
    echo  "POSTGRES .............................. OK   == $url:$port Responsive"
  else
    echo  "POSTGRES .............................. FAIL == $url:$port Non Responsive"
  fi
}







## Services
test_pulp_ca
test_pulp_client
test_katello_default_ca
test_katello_default_ca_stripped
test_katello_server_ca
test_katello_apache
#test_qpid_broker		#OK
#test_katello_tomcat		#OK
test_java_client
test_puppet_client
test_puppet_client_ca
#test_qpid_router_client	#OK
#test_qpid_router_server	#OK
test_qpid_client_striped
test_candlepin-redhat-ca

## DataBase and More
#test_postgres localhost 5432	#OK
#test_mongodb localhost 27017	#OK
#test_squid localhost 3128	#OK
