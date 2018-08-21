Hello all

Script to check Satellite Health, to do it just execute `./satellite_health.sh`, the ouptut should be similar to below
```
[root@sat631 satellite_health]# ./satellite_health.sh 
PULP CA                                 OK     -                                       MD5 Hash from pulp/ca.key and pulp/ca.key match
KATELLO DEFAULT CA                      OK     sat631.local.domain:443                 CA is OK accessing https://sat631.local.domain
KATELLO DEFAULT CA STRIPPED             OK     sat631.local.domain:443                 CA is OK accessing https://sat631.local.domain
KATELLO SERVER CA and KATELLO APACHE    OK     -                                       Verify Response: /etc/pki/katello/certs/katello-apache.crt: OK
QPID BROKER                             OK     localhost:5671                          Responsive                    
TOMCAT                                  OK     sat631.local.domain:8443                Responsive                    
JAVA CLIENT                             OK     localhost:5671                          Responsive                    
QPID ROUTER CLIENT                      OK     localhost:5671                          Responsive                    
QPID ROUTER SERVER                      OK     localhost:5671                          Responsive                    
QPID CLIENT STRIPED                     OK     localhost:5671                          Responsive                    
POSTGRES                                OK     localhost:5432                          Responsive                    
MONGODB                                 OK     localhost:27017                         Responsive                    
SQUID                                   OK     localhost:3128                          Responsive                    
[root@sat631 satellite_health]# 
``` 

or if you would like to see more details, inside the script change `DEBUG=false` to `DEBUG=true` and rerun
```
[root@sat631 satellite_health]# ./satellite_health.sh 
Name ...: PULP CA
Cert ...: /etc/pki/pulp/ca.crt
Key ....: /etc/pki/pulp/ca.key
MD5 Key : d7efd910c337ce1c49d6863e1c9af54a
MD5 Crt : d7efd910c337ce1c49d6863e1c9af54a
PULP CA                                 OK     -                                       MD5 Hash from pulp/ca.key and pulp/ca.key match
Name ...: KATELLO DEFAULT CA
CACert .: /etc/pki/katello/certs/katello-default-ca.crt
Url ....: sat631.local.domain
Port ...: 443
* About to connect() to sat631.local.domain port 443 (#0)
*   Trying 192.168.56.100...
* Connected to sat631.local.domain (192.168.56.100) port 443 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
*   CAfile: /etc/pki/katello/certs/katello-default-ca.crt
  CApath: none
* NSS: client certificate not found (nickname not specified)
* SSL connection using TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
* Server certificate:
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,ST=North Carolina,C=US
* 	start date: Apr 24 21:50:54 2018 GMT
* 	expire date: Jan 17 21:50:54 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
> GET / HTTP/1.1
> User-Agent: curl/7.29.0
> Host: sat631.local.domain
> Accept: */*
> 
< HTTP/1.1 302 Found
< Date: Tue, 21 Aug 2018 13:34:13 GMT
< Server: Apache/2.4.6 (Red Hat Enterprise Linux)
< Cache-Control: no-cache
< X-Request-Id: cc98bb92-daf1-437a-8a65-b9240b3b46a7
< X-Runtime: 0.013909
< Content-Security-Policy: default-src 'self'; child-src 'self'; connect-src 'self' ws: wss:; img-src 'self' data: *.gravatar.com; script-src 'unsafe-eval' 'unsafe-inline' 'self'; style-src 'unsafe-inline' 'self'
< Strict-Transport-Security: max-age=631152000; includeSubdomains
< X-Content-Type-Options: nosniff
< X-Download-Options: noopen
< X-Frame-Options: sameorigin
< X-Permitted-Cross-Domain-Policies: none
< X-XSS-Protection: 1; mode=block
< X-Powered-By: Phusion Passenger 4.0.18
< Set-Cookie: _session_id=49ea2c2e5c70ad92d08cfca1051017fc; path=/; secure; HttpOnly
< Location: https://sat631.local.domain/users/login
< Status: 302 Found
< Transfer-Encoding: chunked
< Content-Type: text/html; charset=utf-8
< 
* Connection #0 to host sat631.local.domain left intact
<html><body>You are being <a href="https://sat631.local.domain/users/login">redirected</a>.</body></html>KATELLO DEFAULT CA                      OK     sat631.local.domain:443                 CA is OK accessing https://sat631.local.domain
Name ...: KATELLO DEFAULT CA STRIPPED
CACert .: /etc/pki/katello/certs/katello-default-ca-stripped.crt
Url ....: sat631.local.domain
Port ...: 443
* About to connect() to sat631.local.domain port 443 (#0)
*   Trying 192.168.56.100...
* Connected to sat631.local.domain (192.168.56.100) port 443 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
*   CAfile: /etc/pki/katello/certs/katello-default-ca-stripped.crt
  CApath: none
* NSS: client certificate not found (nickname not specified)
* SSL connection using TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
* Server certificate:
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,ST=North Carolina,C=US
* 	start date: Apr 24 21:50:54 2018 GMT
* 	expire date: Jan 17 21:50:54 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
> GET / HTTP/1.1
> User-Agent: curl/7.29.0
> Host: sat631.local.domain
> Accept: */*
> 
< HTTP/1.1 302 Found
< Date: Tue, 21 Aug 2018 13:34:13 GMT
< Server: Apache/2.4.6 (Red Hat Enterprise Linux)
< Cache-Control: no-cache
< X-Request-Id: 185ac8bc-2a99-491c-ada2-e56e70f1ead0
< X-Runtime: 0.010542
< Content-Security-Policy: default-src 'self'; child-src 'self'; connect-src 'self' ws: wss:; img-src 'self' data: *.gravatar.com; script-src 'unsafe-eval' 'unsafe-inline' 'self'; style-src 'unsafe-inline' 'self'
< Strict-Transport-Security: max-age=631152000; includeSubdomains
< X-Content-Type-Options: nosniff
< X-Download-Options: noopen
< X-Frame-Options: sameorigin
< X-Permitted-Cross-Domain-Policies: none
< X-XSS-Protection: 1; mode=block
< X-Powered-By: Phusion Passenger 4.0.18
< Set-Cookie: _session_id=425d0d2a4ef448ad4653ac706184ebff; path=/; secure; HttpOnly
< Location: https://sat631.local.domain/users/login
< Status: 302 Found
< Transfer-Encoding: chunked
< Content-Type: text/html; charset=utf-8
< 
* Connection #0 to host sat631.local.domain left intact
<html><body>You are being <a href="https://sat631.local.domain/users/login">redirected</a>.</body></html>KATELLO DEFAULT CA STRIPPED             OK     sat631.local.domain:443                 CA is OK accessing https://sat631.local.domain
Name ...: KATELLO SERVER CA and KATELLO APACHE
ServerCA: /etc/pki/katello/certs/katello-server-ca.crt
Apache .: /etc/pki/katello/certs/katello-apache.crt
KATELLO SERVER CA and KATELLO APACHE    OK     -                                       Verify Response: /etc/pki/katello/certs/katello-apache.crt: OK
Name ...: QPID BROKER
Cert ...: /etc/pki/katello/certs/sat631.local.domain-qpid-broker.crt
Key ....: /etc/pki/katello/private/sat631.local.domain-qpid-broker.key
Url ....: localhost
Port ...: 5671
* About to connect() to localhost port 5671 (#0)
*   Trying ::1...
* Connected to localhost (::1) port 5671 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
*   CAfile: /etc/pki/tls/certs/ca-bundle.crt
  CApath: none
* NSS: client certificate from file
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=pulp,ST=North Carolina,C=US
* 	start date: Jun 19 08:19:06 2018 GMT
* 	expire date: Jan 18 08:19:06 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
* SSL connection using TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
* Server certificate:
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=pulp,ST=North Carolina,C=US
* 	start date: Jun 19 08:19:06 2018 GMT
* 	expire date: Jan 18 08:19:06 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
> GET / HTTP/1.1
> User-Agent: curl/7.29.0
> Host: localhost:5671
> Accept: */*
> 
AMQP
* Connection #0 to host localhost left intact
QPID BROKER                             OK     localhost:5671                          Responsive                    
Name ...: TOMCAT
Cert ...: /etc/pki/katello/certs/katello-tomcat.crt
Key ....: /etc/pki/katello/private/katello-tomcat.key
Url ....: sat631.local.domain
Port ...: 8443
* About to connect() to sat631.local.domain port 8443 (#0)
*   Trying 192.168.56.100...
* Connected to sat631.local.domain (192.168.56.100) port 8443 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
*   CAfile: /etc/pki/tls/certs/ca-bundle.crt
  CApath: none
* NSS: client certificate from file
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,ST=North Carolina,C=US
* 	start date: Apr 24 21:52:17 2018 GMT
* 	expire date: Jan 17 21:52:17 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
* SSL connection using TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
* Server certificate:
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,ST=North Carolina,C=US
* 	start date: Apr 24 21:52:17 2018 GMT
* 	expire date: Jan 17 21:52:17 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
> GET / HTTP/1.1
> User-Agent: curl/7.29.0
> Host: sat631.local.domain:8443
> Accept: */*
> 
< HTTP/1.1 404 Not Found
< Server: Apache-Coyote/1.1
< Content-Length: 0
< Date: Tue, 21 Aug 2018 13:34:14 GMT
< 
* Connection #0 to host sat631.local.domain left intact
TOMCAT                                  OK     sat631.local.domain:8443                Responsive                    
Name ...: JAVA CLIENT
Cert ...: /etc/pki/katello/certs/java-client.crt
Key ....: /etc/pki/katello/private/java-client.key
Url ....: localhost
Port ...: 5671
* About to connect() to localhost port 5671 (#0)
*   Trying ::1...
* Connected to localhost (::1) port 5671 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
*   CAfile: /etc/pki/tls/certs/ca-bundle.crt
  CApath: none
* NSS: client certificate from file
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=candlepin,ST=North Carolina,C=US
* 	start date: Apr 24 21:52:18 2018 GMT
* 	expire date: Jan 17 21:52:19 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
* SSL connection using TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
* Server certificate:
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=pulp,ST=North Carolina,C=US
* 	start date: Jun 19 08:19:06 2018 GMT
* 	expire date: Jan 18 08:19:06 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
> GET / HTTP/1.1
> User-Agent: curl/7.29.0
> Host: localhost:5671
> Accept: */*
> 
AMQP
* Connection #0 to host localhost left intact
JAVA CLIENT                             OK     localhost:5671                          Responsive                    
Name ...: QPID ROUTER CLIENT
Cert ...: /etc/pki/katello/qpid_router_client.crt
Key ....: /etc/pki/katello/qpid_router_client.key
Url ....: localhost
Port ...: 5671
* About to connect() to localhost port 5671 (#0)
*   Trying ::1...
* Connected to localhost (::1) port 5671 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
*   CAfile: /etc/pki/tls/certs/ca-bundle.crt
  CApath: none
* NSS: client certificate from file
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=dispatch client,ST=North Carolina,C=US
* 	start date: Apr 24 21:50:05 2018 GMT
* 	expire date: Jan 17 21:50:05 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
* SSL connection using TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
* Server certificate:
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=pulp,ST=North Carolina,C=US
* 	start date: Jun 19 08:19:06 2018 GMT
* 	expire date: Jan 18 08:19:06 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
> GET / HTTP/1.1
> User-Agent: curl/7.29.0
> Host: localhost:5671
> Accept: */*
> 
AMQP
* Connection #0 to host localhost left intact
QPID ROUTER CLIENT                      OK     localhost:5671                          Responsive                    
Name ...: QPID ROUTER SERVER
Cert ...: /etc/pki/katello/qpid_router_server.crt
Key ....: /etc/pki/katello/qpid_router_server.key
Url ....: localhost
Port ...: 5671
* About to connect() to localhost port 5671 (#0)
*   Trying ::1...
* Connected to localhost (::1) port 5671 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
*   CAfile: /etc/pki/tls/certs/ca-bundle.crt
  CApath: none
* NSS: client certificate from file
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=dispatch server,ST=North Carolina,C=US
* 	start date: Apr 24 21:50:17 2018 GMT
* 	expire date: Jan 17 21:50:17 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
* SSL connection using TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
* Server certificate:
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=pulp,ST=North Carolina,C=US
* 	start date: Jun 19 08:19:06 2018 GMT
* 	expire date: Jan 18 08:19:06 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
> GET / HTTP/1.1
> User-Agent: curl/7.29.0
> Host: localhost:5671
> Accept: */*
> 
AMQP
* Connection #0 to host localhost left intact
QPID ROUTER SERVER                      OK     localhost:5671                          Responsive                    
Name ...: QPID CLIENT STRIPED
Cert ...: /etc/pki/katello/qpid_client_striped.crt
Url ....: localhost
Port ...: 5671
* About to connect() to localhost port 5671 (#0)
*   Trying ::1...
* Connected to localhost (::1) port 5671 (#0)
* Initializing NSS with certpath: sql:/etc/pki/nssdb
*   CAfile: /etc/pki/tls/certs/ca-bundle.crt
  CApath: none
* NSS: client certificate from file
* 	subject: CN=pulp-qpid-client-cert,OU=SomeOrgUnit,O=PULP,ST=North Carolina,C=US
* 	start date: Apr 24 21:55:23 2018 GMT
* 	expire date: Jan 17 21:55:23 2038 GMT
* 	common name: pulp-qpid-client-cert
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
* SSL connection using TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
* Server certificate:
* 	subject: CN=sat631.local.domain,OU=SomeOrgUnit,O=pulp,ST=North Carolina,C=US
* 	start date: Jun 19 08:19:06 2018 GMT
* 	expire date: Jan 18 08:19:06 2038 GMT
* 	common name: sat631.local.domain
* 	issuer: CN=sat631.local.domain,OU=SomeOrgUnit,O=Katello,L=Raleigh,ST=North Carolina,C=US
> GET / HTTP/1.1
> User-Agent: curl/7.29.0
> Host: localhost:5671
> Accept: */*
> 
AMQP
* Connection #0 to host localhost left intact
QPID CLIENT STRIPED                     OK     localhost:5671                          Responsive                    
Url ....: localhost
Port ...: 5432
You are connected to database "foreman" as user "postgres" via socket in "/var/run/postgresql" at port "5432".
POSTGRES                                OK     localhost:5432                          Responsive                    
Url ....: localhost
Port ...: 27017
MongoDB shell version: 2.6.11
connecting to: test
switched to db pulp_database
bye
MONGODB                                 OK     localhost:27017                         Responsive                    
Url ....: localhost
Port ...: 3128
SQUID                                   OK     localhost:3128                          Responsive                    
[root@sat631 satellite_health]#
```

Hope you enjoy it.

Waldirio
