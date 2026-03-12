#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief
# @description a

# @description func b
# @set B int Error code if an erorr occured
# @set C array Some array thing
b() {
}

EOF

tests:put expected <<EOF
# Project Name

Brief

## Overview

a

## Index

* [b](#b)

## b

func b

### Variables set

* **B** (int): Error code if an erorr occured
* **C** (array): Some array thing
EOF

assert
