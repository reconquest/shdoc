#!/bin/bash
# @file test/testcases/@stderr.test.sh
# @author Pierre-Yves Landuré < contact at biapy dot fr >
# @brief Test cases for @stderr keyword.
# @description
#   Test these @stderr comportements:
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
# @name shdoc @stderr tests
# @brief Test @stderr functionnality.
# @description Tests for shdoc processing of @stderr keyword.

# @description test-stderr dummy function.
# @stderr Standard stderr message.
# @stdout section should appear before stderr section.
# @see see-also-after-stderr-section
# @stderr Stderr message with [markdown link](https://github.com/reconquest/shdoc).
# @stderr       Indented with spaces stderr message.
# @stderr Multiple lines
#   stderr message.
# line outside of multiple lines stderr message (ignored).
# @stderr Failed multiple lines
    # std err message.
    #   @stderr Idented multiple lines
    #       stderr message
# @stderr Stderr message with trailing spaces.      
test-stderr() {
}
EOF

tests:put expected <<EOF
# shdoc @stderr tests

Test @stderr functionnality.

## Overview

Tests for shdoc processing of @stderr keyword.

## Index

* [test-stderr](#test-stderr)

## test-stderr

test-stderr dummy function.

### Output on stdout

* section should appear before stderr section.

### Output on stderr

* Standard stderr message.
* Stderr message with [markdown link](https://github.com/reconquest/shdoc).
* Indented with spaces stderr message.
* Multiple lines
  stderr message.
* Failed multiple lines
* Idented multiple lines
  stderr message
* Stderr message with trailing spaces.

### See also

* [see-also-after-stderr-section](#see-also-after-stderr-section)

EOF

assert
