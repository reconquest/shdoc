#!/bin/bash

tests:put input <<EOF
#!/usr/bin/env bash
# @file testdoc.sh
# @brief Demo
# @description Demonstration.

# @description
#       A multiline description with multi-level list
#       to test empty line detection, and static indentation cleaning.
#
#       - This is a line.
#       - Second line with sub list.
#         - Sublist, with indentation
#         - Sublist second item.
#       - Main list.
#
# @example with ignored text that could be an introduction
#
#   testme
#
#   echo "Another part of the example, separated by an empty line."
#   testme "with an argument"
#
# @noargs
testme() {
    echo "Hello"
}

if [[ 1 -eq 2 ]]; then

    # @description Another bit of
    # comment.
    #
    # @example
    #   testus()
    #
    # @noargs
    testus() {
        echo "Hello"
    }
fi
EOF

tests:put expected <<EOF
# testdoc.sh

Demo

## Overview

Demonstration.

## Index

* [testme](#testme)
* [testus](#testus)

### testme

A multiline description with multi-level list
to test empty line detection, and static indentation cleaning.

- This is a line.
- Second line with sub list.
  - Sublist, with indentation
  - Sublist second item.
- Main list.

#### Example

\`\`\`bash
testme

echo "Another part of the example, separated by an empty line."
testme "with an argument"
\`\`\`

_Function has no arguments._

### testus

Another bit of
comment.

#### Example

\`\`\`bash
testus()
\`\`\`

_Function has no arguments._

EOF

assert
