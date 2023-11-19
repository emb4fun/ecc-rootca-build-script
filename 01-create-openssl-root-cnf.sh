#!/bin/bash

echo ""                     >  ./_cfg/openssl_root_head.cnf   
echo "root_c  = ${root_c}"  >> ./_cfg/openssl_root_head.cnf
echo "root_st = ${root_st}" >> ./_cfg/openssl_root_head.cnf
echo "root_o  = ${root_o}"  >> ./_cfg/openssl_root_head.cnf
echo "root_ou = ${root_ou}" >> ./_cfg/openssl_root_head.cnf
echo "root_cn = ${root_cn}" >> ./_cfg/openssl_root_head.cnf
echo ""                     >> ./_cfg/openssl_root_head.cnf

cat ./_cfg/openssl_root_head.cnf ./_cfg/openssl_root_body.cnf > ./_cfg/openssl_root.cnf 

#*** EOF ***
