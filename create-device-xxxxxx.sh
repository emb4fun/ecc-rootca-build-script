#!/bin/bash

# Store hex folder name
hex=$1

# Goto CA
cd ca

#
# Check if "device" folder is available, if not create it
#
if [ ! -d "device" ]; then
   mkdir device   
fi
cd device

#
# If hex device folder is not available, create it
#
if [ ! -d "$hex" ]; then
   # Create device folder   
   mkdir $hex
   cd $hex
else
   # Delete old content
   cd $hex
   rm *
fi   

#
# Create device.cfg
#
echo > device_head.cfg
echo device_cn = tiny$hex.local    >> device_head.cfg
echo device_ou = "$root_o Devices" >> device_head.cfg
echo device_o  = $root_o           >> device_head.cfg
echo device_c  = $root_c           >> device_head.cfg

cat device_head.cfg ../../../_cfg/device_body.cfg > device.cfg
rm device_head.cfg

#
# Create the device key
#
openssl ecparam -genkey -name prime256v1 -out device.key

#
# Generate the certificate signing request
#
openssl req -new -key device.key -out device.csr -config device.cfg

#
# Self-Signing the CSR to create the Certificate
#
openssl x509 -req -days 500 -sha256 -extfile device.cfg -extensions v3_req -in device.csr \
   -CA ../../intermediate/certs/intermediate.cert.pem \
   -CAkey ../../intermediate/private/intermediate.key.pem \
   -CAcreateserial -out device.crt   

# Remove device configuration, will not be used anymore
rm device.cfg

# Copy in intermediate certificate
cp ../../intermediate/certs/intermediate.cert.pem intermed.crt
     
# Create certification chain
cat device.crt intermed.crt > chain.crt
     
#*** EOF ***
