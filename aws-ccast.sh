#!/bin/bash

pip install --upgrade --user awsebcli
mkdir HelloWorld
cd HelloWorld
eb init -p PHP
eb create dev-env
openssl genrsa -des3 -out server.key 1024
openssl req -new -key server.key -out server.csr
cp server.key server.key.org
openssl rsa -in server.key.org -out server.key
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
aws iam upload-server-certificate --server-certificate-name JollyBuyInc --certificate-body file://server.crt --private-key file://server.key

