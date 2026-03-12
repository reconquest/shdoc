
tests:put input <<EOF
# @name Project Name
# @brief Brief
# @description a
# b

# @section Section A
# @description a
# a

# @description func a
# line a 2
# @noargs
a() {
}

# @endsection

# @description func b
# ab
# @noargs
b() {
}
EOF

tests:put expected <<EOF
# Project Name

Brief

## Overview

a
b

## Index

* [Section A](#section-a)
  * [a](#a)
* [b](#b)

## Section A

a
a

### a

func a
line a 2

_Function has no arguments._

## b

func b
ab

_Function has no arguments._

EOF

assert
