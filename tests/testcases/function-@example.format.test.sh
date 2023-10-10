#!/bin/bash

tests:put input <<EOF
# @description Multiline description goes here and
# there
#
# @example text
#   some:other:func a b c
#   echo 123
#
some:first:func() {
EOF

tests:put expected <<EOF
## Index

* [some:first:func](#somefirstfunc)

### some:first:func

Multiline description goes here and
there

#### Example

\`\`\`text
some:other:func a b c
echo 123
\`\`\`

EOF

assert
