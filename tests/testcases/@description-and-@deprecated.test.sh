#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief
# @description overview

# @description My super function. Not thread safe.
# @deprecated use some other thing instead
some:first:func() {
    :
}
EOF

tests:put expected <<EOF
# Project Name

Brief

## Overview

overview

## Index

* [some:first:func](#somefirstfunc)

### some:first:func

[![Deprecated use some other thing instead](https://img.shields.io/badge/Deprecated-use%20some%20other%20thing%20instead-red.svg)](#)

My super function. Not thread safe.
EOF

assert
