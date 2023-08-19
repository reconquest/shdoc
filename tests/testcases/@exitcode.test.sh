#!/bin/bash

tests:put input <<EOF
# @name Project Name
# @brief Brief
# @description the file description
# with some more lines

# @description The func b description
# @exitcode 0  If everything is alright.    
# @exitcode 1  If one of this errors occured  :
#
#   - Bad number of arguments:
#     - Too many arguments.
#     - Too few arguments.
#   - Invalid argument format.
#
# @exitcode >1 If a issue occured during processing,
#              with a long comment here on the issue.
b() {
}

EOF

tests:put expected <<EOF
# Project Name

Brief

## Overview

the file description
with some more lines

## Index

* [b](#b)

### b

The func b description

#### Exit codes

* **0**:  If everything is alright.
* **1**:  If one of this errors occured  :
  
  - Bad number of arguments:
    - Too many arguments.
    - Too few arguments.
  - Invalid argument format.
* **>1**: If a issue occured during processing,
  with a long comment here on the issue.

EOF

assert
