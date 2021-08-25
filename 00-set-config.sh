#!/bin/bash

export root_c="DE"
export root_st="Hesse"
export root_o="Example"

###################################################################

export root_ou="$root_o Certificate Authority"
export root_cn="$root_o Non-Public ECC Root CA"

###################################################################

export inter_c=$root_c
export inter_st=$root_st
export inter_o=$root_o
export inter_ou="$inter_o Certificate Authority"
export inter_cn="$inter_o Non-Public ECC CA"


#*** EOF ***
