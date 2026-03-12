# Verify that @section blocks allow a certain subset of other annotions:
# - @see
# - @example
# - @set
# - others should be ignored
#
# Resulting lines must be part of the section and not appear in the next function

tests:put input <<EOF
# @name Project Name
# @brief Brief
# @description a
# b

# @section Section A
# @see [some-link](./some-link)
# @description first line
# second line
# @noargs
# @stdin
# @example
#   SOME_VAR=x ./script-name
#
# @set ENV int purpose of life

# @description func a
# line a 2
# @noargs
a() {
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

## Section A

first line
second line

### Example

\`\`\`bash
SOME_VAR=x ./script-name
\`\`\`

### Variables set

* **ENV** (int): purpose of life

### a

func a
line a 2

_Function has no arguments._

EOF

assert
