#!/bin/bash

tests:put input <<EOF
# @description Multiline description goes here and
# there
#
# @example
#   some:other:func a b c
#   echo 123
#
# @arg \$1 string Some arg.
# @arg \$@ any Rest of arguments.
#
# @noargs
#
# @set A string Variable was set
#
# @exitcode 0  If successfull.
# @exitcode >0 On failure
# @exitcode 5  On some error.
#
# @stdin Path to something.
# @stdout Path to something.
# @stderr Stderr description.
#
# @see some:other:func()
# @see Shell documation generator [shdoc](https://github.com/reconquest/shdoc).
some:first:func() {
EOF

tests:put expected <<EOF
## Index

* [some:first:func](#somefirstfunc)

## some:first:func

Multiline description goes here and
there

### Example

\`\`\`bash
some:other:func a b c
echo 123
\`\`\`

### Arguments

* **\$1** (string): Some arg.
* **...** (any): Rest of arguments.

_Function has no arguments._

### Variables set

* **A** (string): Variable was set

### Exit codes

* **0**:  If successfull.
* **>0**: On failure
* **5**:  On some error.

### Input on stdin

* Path to something.

### Output on stdout

* Path to something.

### Output on stderr

* Stderr description.

### See also

* [some:other:func()](#someotherfunc)
* Shell documation generator [shdoc](https://github.com/reconquest/shdoc).
EOF

assert
