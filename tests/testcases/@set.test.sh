#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief
# @description a

# @description func b
# @set B int Error code if an error occured
#   with some list to add details.
#
#   - detail A
#     - detail B
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

### b

func b

#### Variables set

* **B** (int): Error code if an error occured
  with some list to add details.
  
  - detail A
    - detail B
* **C** (array): Some array thing
EOF

assert
