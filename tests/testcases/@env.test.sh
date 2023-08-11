#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief
# @description a

# @description func b
# @env B int use B in order to do important things
# @env C array Some array thing
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

### b

func b

#### Environment variables

* **B** (int): use B in order to do important things
* **C** (array): Some array thing
EOF

assert
