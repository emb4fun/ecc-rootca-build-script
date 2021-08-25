#!/bin/bash

#
# OpenSSL Certificate Authority
#
# See: https://jamielinux.com/docs/openssl-certificate-authority/index.html
#


###################################
# Create the directory structure
###################################

clear

mkdir ca
cd ca

mkdir certs crl newcerts private
chmod 700 private
touch index.txt
touch index.txt.attr
openssl rand -hex 16 > serial
cp ../_cfg/openssl_root.cnf openssl.cnf

mkdir intermediate
cd intermediate
mkdir certs crl csr newcerts private
chmod 700 private
touch index.txt
touch index.txt.attr
cp ../../_cfg/openssl_intermediate.cnf openssl.cnf
cd ../..

###################################
# Create the root pair
###################################

cd ca


#
# Create the root key
#
echo ""
echo "*** Create the root key and root certificate ***"
echo ""

openssl ecparam -genkey -name secp384r1 -out private/ca.key.pem
chmod 400 private/ca.key.pem


#
# Create the root certificate
#

openssl req -config openssl.cnf \
      -key private/ca.key.pem \
      -new -x509 -days 7305 -sha256 -extensions v3_ca \
      -out certs/ca.cert.pem

chmod 444 certs/ca.cert.pem


#
# Verify the root certificate
#
echo ""
echo "*** Verify the root certificate ***"
echo ""

openssl x509 -noout -text -in certs/ca.cert.pem

echo ""
read -p"Verify the root certificate and press any key to continue..."
clear


###################################
# Create the intermediate pair
###################################

#
# Create the intermediate key
#
echo ""
echo "*** Create the intermediate key and intermediate certificate ***"
echo ""

openssl ecparam -genkey -name prime256v1 -out intermediate/private/intermediate.key.pem
chmod 400 intermediate/private/intermediate.key.pem


#
# Create the intermediate certificate
#

openssl req -config intermediate/openssl.cnf -new -sha256 \
      -key intermediate/private/intermediate.key.pem \
      -out intermediate/csr/intermediate.csr.pem

openssl ca -config openssl.cnf -extensions v3_intermediate_ca \
      -days 3653 -notext -md sha256 \
      -in intermediate/csr/intermediate.csr.pem \
      -out intermediate/certs/intermediate.cert.pem

chmod 444 intermediate/certs/intermediate.cert.pem


#
# Verify the intermediate certificate
# 
echo ""
echo "*** Verify the intermediate certificate ***"
echo ""

openssl x509 -noout -text -in intermediate/certs/intermediate.cert.pem
openssl verify -CAfile certs/ca.cert.pem intermediate/certs/intermediate.cert.pem

echo ""
read -p"Verify the intermediate certificate and press any key to continue..."
clear


#
# Create the certificate chain file
#

cat intermediate/certs/intermediate.cert.pem \
      certs/ca.cert.pem > intermediate/certs/ca-chain.cert.pem

chmod 444 intermediate/certs/ca-chain.cert.pem


#*** EOF ***
