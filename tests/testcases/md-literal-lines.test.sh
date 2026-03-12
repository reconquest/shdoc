#!/bin/bash

tests:put input <<EOF
# @file Literal MD tests
# @brief Test for files
# @description
#   |   3 leading blanks before | should be trimmed because line start is not '#|'
# 
#|This line is taken literally, including the 5 spaces at the end     
#|     This has 5 leading spaces

# @section Test literal md for section description
# @description
#
# Combined with code fence
# ~~~json
#|{
#|  "key": "value"
#|}
# ~~~
# @endsection

# @description Check literal in function descriptions.
# Use table syntax.
#
# **Note:**  
# The literal marker '#|' has rudimentary detection for tables.
# 1. Any space before the first standalone '|' is trimmed when not in literal mode (using `#|`)
# 2. When a line starts with #| and ends with `|[ ]*$`,
#    the pipe from the literal marker `#|` will not be stripped.
#
# Table with slight indention
#| | literal | table |
#| |  :---:  | :---: |
#| | keep?   | yes   |
#
# Indented, but not in literal mode
#   | literal | table |
#      |  :---:  | :---: |
#  | keep?   | yes   |
#
# Directly at line start
#|| literal | table |
#||  :---:  | :---: |
#|| keep?   | yes   |
#
# Without duplicate left pipes
#| literal | table |
#|  :---:  | :---: |
#| keep?   | yes   |
function literal-table {
    echo abc
}
EOF

tests:put expected <<EOF
# Literal MD tests

Test for files

## Overview

|   3 leading blanks before | should be trimmed because line start is not '#|'

This line is taken literally, including the 5 spaces at the end     
     This has 5 leading spaces

## Index

* [Test literal md for section description](#test-literal-md-for-section-description)
* [literal-table](#literal-table)

## Test literal md for section description

Combined with code fence
~~~json
{
  "key": "value"
}
~~~

## literal-table

Check literal in function descriptions.
Use table syntax.

**Note:**  
The literal marker '#|' has rudimentary detection for tables.
1. Any space before the first standalone '|' is trimmed when not in literal mode (using `#|`)
2. When a line starts with #| and ends with `|[ ]*$`,
the pipe from the literal marker `#|` will not be stripped.

Table with slight indention
 | literal | table |
 |  :---:  | :---: |
 | keep?   | yes   |

Indented, but not in literal mode
| literal | table |
|  :---:  | :---: |
| keep?   | yes   |

Directly at line start
| literal | table |
|  :---:  | :---: |
| keep?   | yes   |

Without duplicate left pipes
 literal | table |
  :---:  | :---: |
 keep?   | yes   |

EOF

assert
