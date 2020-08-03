#!/bin/bash

echo ""                       >  ./_cfg/openssl_intermediate_head.cnf   
echo "inter_c  = ${inter_c}"  >> ./_cfg/openssl_intermediate_head.cnf
echo "inter_st = ${inter_st}" >> ./_cfg/openssl_intermediate_head.cnf
echo "inter_o  = ${inter_o}"  >> ./_cfg/openssl_intermediate_head.cnf
echo "inter_ou = ${inter_ou}" >> ./_cfg/openssl_intermediate_head.cnf
echo "inter_cn = ${inter_cn}" >> ./_cfg/openssl_intermediate_head.cnf
echo ""                       >> ./_cfg/openssl_intermediate_head.cnf

cat ./_cfg/openssl_intermediate_head.cnf ./_cfg/openssl_intermediate_body.cnf > ./_cfg/openssl_intermediate.cnf 


#*** EOF ***
