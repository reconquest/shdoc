#!/usr/bin/env bash

tests:put input <<EOF
# @description example function 1
#
# @noargs
some:first:func() {
	echo "test"
}

# @description function with underscores
#
# @noargs
some_other_func() {
	echo "test"
}
EOF

tests:put expected <<EOF
## Index

* [some:first:func](#somefirstfunc)
* [some_other_func](#someotherfunc)

### some:first:func

example function 1

_Function has no arguments._

### some_other_func

function with underscores

_Function has no arguments._

EOF

assert
