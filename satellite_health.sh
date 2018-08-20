#!/bin/bash

# Script to check Satellite Health

SSL_BUILD="/root/ssl-build/"


qpid_broker_test()
{
  #set -x
  cert_full_name=$1
  crt_file=$1
  key_file=$(echo $cert_full_name | sed -e 's/.crt/.key/g')
  server=$2
  url=$3
  port=$4

#  echo "Server == $server"
#  echo "Cert File == $cert_full_name"

  curl --cert $SSL_BUILD/$server/$crt_file \
	--key $SSL_BUILD/$server/$key_file \
	-k https://$url:$port 1>/dev/null 2>/dev/null

  if [ $? -eq 0 ]; then
    echo  "QPID BROKER OK == $url:$port Responsive"
  else
    echo  "QPID BROKER FAIL == $url:$port Non Responsive"
  fi
}

qpid_client_client_test()
{
  #set -x
  cert_full_name=$1
  crt_file=$1
  key_file=$(echo $cert_full_name | sed -e 's/.crt/.key/g')
  server=$2
  url=$3
  port=$4

#  echo "Server == $server"
#  echo "Cert File == $cert_full_name"

  curl --cert $SSL_BUILD/$server/$crt_file \
	--key $SSL_BUILD/$server/$key_file \
	-k https://$url:$port 1>/dev/null 2>/dev/null

  if [ $? -eq 0 ]; then
    echo  "QPID ROUTER CLIENT OK == $url:$port Responsive"
  else
    echo  "QPID ROUTER CLIENT FAIL == $url:$port Non Responsive"
  fi
}

qpid_router_client_test()
{
  #set -x
  cert_full_name=$1
  crt_file=$1
  key_file=$(echo $cert_full_name | sed -e 's/.crt/.key/g')
  server=$2
  url=$3
  port=$4

#  echo "Server == $server"
#  echo "Cert File == $cert_full_name"

  curl --cert $SSL_BUILD/$server/$crt_file \
	--key $SSL_BUILD/$server/$key_file \
	-k https://$url:$port 1>/dev/null 2>/dev/null

  if [ $? -eq 0 ]; then
    echo  "QPID ROUTER CLIENT OK == $url:$port Responsive"
  else
    echo  "QPID ROUTER CLIENT FAIL == $url:$port Non Responsive"
  fi
}

qpid_router_server_test()
{
  #set -x
  cert_full_name=$1
  crt_file=$1
  key_file=$(echo $cert_full_name | sed -e 's/.crt/.key/g')
  server=$2
  url=$3
  port=$4

#  echo "Server == $server"
#  echo "Cert File == $cert_full_name"

  curl --cert $SSL_BUILD/$server/$crt_file \
	--key $SSL_BUILD/$server/$key_file \
	-k https://$url:$port 1>/dev/null 2>/dev/null

  if [ $? -eq 0 ]; then
    echo  "QPID ROUTER SERVER OK == $url:$port Responsive"
  else
    echo  "QPID ROUTER SERVER FAIL == $url:$port Non Responsive"
  fi
}

tomcat_test()
{
  #set -x
  cert_full_name=$1
  crt_file=$1
  key_file=$(echo $cert_full_name | sed -e 's/.crt/.key/g')
  server=$2

#  echo "Server == $server"
#  echo "Cert File == $cert_full_name"

  curl --cert $SSL_BUILD/$server/$crt_file \
	--key $SSL_BUILD/$server/$key_file \
	-k https://$server:8443

  if [ $? -eq 0 ]; then
    echo  "TOMCAT OK ==  $server:8443 Responsive"
  else
    echo  "TOMCAT FAIL == $server:8443 Non Responsive"
  fi
}

test_area()
{
  cert_full_name=$1
  server=$2

#  echo "=== $1" 
  check_param=$(echo $cert_full_name | sed -e 's/.crt//g' | grep "\." | wc -l)
  if [ $check_param -eq 0 ]; then
    cert_name=$1
  else
    cert_name=$(echo $cert_full_name | cut -d- -f2-)
  fi
 

  case $cert_name in

    java-client.crt)
      echo  "Java Client" 
      ;;
    pulp-client.crt)
      echo  "Pulp Client" 
      ;;
    apache.crt)
      echo  "Apache" 
      ;;
    foreman-client.crt)
      echo  "Foreman Client" 
      ;;
    foreman-proxy-client.crt)
      echo  "Foreman Proxy Client" 
      ;;
    foreman-proxy.crt)
      echo  "Foreman Proxy" 
      ;;
    puppet-client.crt)
      echo  "Puppet Client" 
      ;;
    qpid-broker.crt)
      #echo  "Qpid Broker" 
      qpid_broker_test $cert_full_name $server localhost 5671
      ;;
    qpid-client-cert.crt)
      #echo  "Qpid Client" 
      qpid_client_client_test $cert_full_name $server localhost 5671
      ;;
    qpid-router-client.crt)
      #echo  "Qpid Router Client" 
      qpid_router_client_test $cert_full_name $server localhost 5671
      ;;
    qpid-router-server.crt)
      #echo  "Qpid Router Server" 
      qpid_router_server_test $cert_full_name $server localhost 5671
      ;;
    tomcat.crt)
      #echo  "Tomcat" 
      tomcat_test $cert_full_name $server $server 8443
      ;;
  esac
}

generated_certs()
{
  server=$1
  echo "Generated Certs"
  cert_list=$(ls /root/ssl-build/$server/*.crt | cut -d/ -f5)
  for b in $cert_list
  do
    #echo - $b
    test_area $b $server
  done 
}

check_servers()
{
  echo "Server List"
  #servers="sat631.local.domain"
  servers=$(ls -l $SSL_BUILD | grep ^d | awk '{print $NF}')

  for b in $servers
  do
    echo - $b
    generated_certs $b
  done
}

check_servers
