#!/bin/bash
# @file test/testcases/@stdout.test.sh
# @author Pierre-Yves Landuré < contact at biapy dot fr >
# @brief Test cases for @stdout keyword.
# @description
#   Test these @stdout comportements:
#   - simple one line message.
#   - one line message with indentation and trailing spaces.
#   - indented two lines message.
#   - three lines message with trailing spaces.
#   - appears between @stdin and @stderr sections.

tests:put input <<EOF
# @name shdoc @stdout tests
# @brief Test @stdout functionnality.
# @description Tests for shdoc processing of @stdout keyword.

# @description test-stdout dummy function.
# @see see-also-after-stderr-section
# @stdout simple one line message.
# @stdout         one line message with indentation and trailing spaces.    
    #   @stdout   indented two lines message
    #         to test how indentation is trimmed.
    #   Message without sufficient indentation (ignored).
# @stderr Error output description.
# @stdout tree lines messages    
#     with trailing spaces    
#   and random indentation.  
# @stdin Input stream description.
test-stdout() {
}
EOF

tests:put expected <<EOF
# shdoc @stdout tests

Test @stdout functionnality.

## Overview

Tests for shdoc processing of @stdout keyword.

## Index

* [test-stdout](#test-stdout)

## test-stdout

test-stdout dummy function.

### Input on stdin

* Input stream description.

### Output on stdout

* simple one line message.
* one line message with indentation and trailing spaces.
* indented two lines message
  to test how indentation is trimmed.
* tree lines messages
  with trailing spaces
  and random indentation.

### Output on stderr

* Error output description.

### See also

* [see-also-after-stderr-section](#see-also-after-stderr-section)

EOF

assert
