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

**DEPRECATED.** My super function. Not thread safe.
EOF

assert
