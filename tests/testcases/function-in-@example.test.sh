#!/bin/bash

tests:put input <<EOF
# @description Same, as \`tests:eval\`, but writes stdout into given variable and
# return stderr as expected.
#
# @example
#   _x() {
#       echo "y [\$@]"
#   }
#   tests:value response _x a b c
#   tests:assert-equals "\$response" "y [a b c]"
#
# @arg \$1 string Variable name.
# @arg \$@ string String to evaluate.
# @see tests:eval
tests:value() {
    local __variable__="\$1"
    local __value__=""
    shift

    tests:ensure "\${@}"

    __value__="\$(cat "\$(tests:get-stdout-file)")"
    eval \$__variable__=\"\${__value__}\"

}
EOF

tests:put expected <<EOF
## Index

* [tests:value](#testsvalue)

## tests:value

Same, as \`tests:eval\`, but writes stdout into given variable and
return stderr as expected.

### Example

\`\`\`bash
_x() {
    echo "y [\$@]"
}
tests:value response _x a b c
tests:assert-equals "\$response" "y [a b c]"
\`\`\`

### Arguments

* **\$1** (string): Variable name.
* **...** (string): String to evaluate.

### See also

* [tests:eval](#testseval)
EOF

assert
