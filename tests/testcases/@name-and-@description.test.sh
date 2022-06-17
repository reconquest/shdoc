#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief
# @description a
# b
# c

# @description func a
# line a 2
# @noargs
a() {
}

# @description func b
# ab
# @noargs
b() {
}

# @description func c
# @example
#      echo 1
#     echo 2
c() {
}
EOF

tests:put expected <<EOF
# Project Name

Brief

## Overview

a
b
c

## Index

* [a](#a)
* [b](#b)
* [c](#c)

### a

func a
line a 2

_Function has no arguments._

### b

func b
ab

_Function has no arguments._

### c

func c

#### Example

\`\`\`bash
 echo 1
echo 2
\`\`\`

EOF

assert
