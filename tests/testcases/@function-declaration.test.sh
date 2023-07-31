#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief
# @description the file description
# with some more lines

# @description Function n°1
a() {
    echo "a"
}

# @description Function n°2
b() { echo "b" ; }

# @description Function n°3
:c() { echo "c"; }

# @description Function n°4
d-method()
{ echo "d"; }

# @description Function n°5
function e:function { echo "e"; }

# @description Function n°6
function f() { echo "f"; }

# @description Function n°7
function g
{ echo "g"; }

# @description Function n°8
function h()
{ echo "h"; }

a
b
:c
d-method
e:function
f
g
h
EOF

tests:put expected <<EOF
# Project Name

Brief

## Overview

the file description
with some more lines

## Index

* [a](#a)
* [b](#b)
* [:c](#c)
* [d-method](#d-method)
* [e:function](#efunction)
* [f](#f)
* [g](#g)
* [h](#h)

### a

Function n°1

### b

Function n°2

### :c

Function n°3

### d-method

Function n°4

### e:function

Function n°5

### f

Function n°6

### g

Function n°7

### h

Function n°8

EOF

assert
