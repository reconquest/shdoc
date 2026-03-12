# Basic test of sections:
# - title
# - description
# - must appear in toc
# - nested functions should be nested in toc also
# - should also appear when there is no function in it

tests:put input <<EOF
# @name Project Name
# @brief Brief
# @description a
# b

# @section Section A
# @description line 1
# line 2

# @description func a
# line a 2
# @noargs
a() {
}

# @section Section B
# @description b

# @description func b
# ab
# @noargs
b() {
}

# @section Generic block without functions
# @description Here comes the main logic
# which uses the building blocks from above

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
* [Section B](#section-b)
  * [b](#b)
* [Generic block without functions](#generic-block-without-functions)

## Section A

line 1
line 2

### a

func a
line a 2

_Function has no arguments._

## Section B

b

### b

func b
ab

_Function has no arguments._

## Generic block without functions

Here comes the main logic
which uses the building blocks from above

EOF

assert
