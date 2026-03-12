#!/bin/bash
# @file test/testcases/@see.test.sh
# @author Pierre-Yves Landuré < contact at biapy dot fr >
# @brief Test cases for @see keyword.
# @description
#   Test these @see comportements:
#   - one string (i.e. function name.)
#   - two strings
#   - function name containing ':'.
#   - string starting by '.'
#   - one relative path starting with './'.
#   - one relative path starting with '../'.
#   - one absolute path.
#   - string that is not a relative path (starting with '.../').
#   - a https URL.
#   - a file URL.
#   - a URL in a text.
#   - two URL in a text.
#   - a markdown link.
#   - a text containing a markdown link.
#   - a text containing a markdown link and a URL.
tests:put input <<EOF
# @name shdoc @see tests
# @brief Test @see functionnality.
# @description Tests for shdoc processing of @see keyword.

# @description test-see dummy function.
# @see test-failing-see
# @see test-working-see test-failing-see
# @see some:other:func()
# @see .string-starting-by-dot
# @see ./some/relative/path
# @see ../some/other/relative/path
# @see /some/absolute/path
# @see .../some/strange/string
# @see https://github.com/reconquest/shdoc
# @see file://var/log/syslog
# @see shdoc: https://github.com/reconquest/shdoc
# @see shdoc (https://github.com/reconquest/shdoc) and https://github.com/reconquest/import.bash
# @see [shdoc](https://github.com/reconquest/shdoc)
# @see Shell documation generator [shdoc](https://github.com/reconquest/shdoc).
# @see Shell documation generator [shdoc](https://github.com/reconquest/shdoc) (and https://github.com/reconquest/import.bash).
test-working-see() {
}

EOF

tests:put expected <<EOF
# shdoc @see tests

Test @see functionnality.

## Overview

Tests for shdoc processing of @see keyword.

## Index

* [test-working-see](#test-working-see)

## test-working-see

test-see dummy function.

### See also

* [test-failing-see](#test-failing-see)
* [test-working-see test-failing-see](#test-working-see-test-failing-see)
* [some:other:func()](#someotherfunc)
* [.string-starting-by-dot](#string-starting-by-dot)
* [./some/relative/path](./some/relative/path)
* [../some/other/relative/path](../some/other/relative/path)
* [/some/absolute/path](/some/absolute/path)
* [.../some/strange/string](#somestrangestring)
* [https://github.com/reconquest/shdoc](https://github.com/reconquest/shdoc)
* [file://var/log/syslog](file://var/log/syslog)
* shdoc: [https://github.com/reconquest/shdoc](https://github.com/reconquest/shdoc)
* shdoc ([https://github.com/reconquest/shdoc](https://github.com/reconquest/shdoc)) and [https://github.com/reconquest/import.bash](https://github.com/reconquest/import.bash)
* [shdoc](https://github.com/reconquest/shdoc)
* Shell documation generator [shdoc](https://github.com/reconquest/shdoc).
* Shell documation generator [shdoc](https://github.com/reconquest/shdoc) (and [https://github.com/reconquest/import.bash](https://github.com/reconquest/import.bash)).
EOF

assert
