#!/bin/bash
# @file test/testcases/@stdin.test.sh
# @author Pierre-Yves Landuré < contact at biapy dot fr >
# @brief Test cases for @stdin keyword.
# @description
#   Test these @stdin comportements:
#   - simple one line message.
#   - one line message with indentation and trailing spaces.
#   - indented two lines message.
#   - three lines message with trailing spaces.
#   - appears between @stdin and @stderr sections.

tests:put input <<EOF
# @name shdoc @stdin tests
# @brief Test @stdin functionnality.
# @description Tests for shdoc processing of @stdin keyword.
# @description test-stdin dummy function.
# @see see-also-after-stderr-section
# @stdin simple one line message.
# @stdout Stdout section appears after stdin section.
# @stdin         one line message with indentation and trailing spaces.    
    #   @stdin   indented two lines message
    #         to test how indentation is trimmed.
    #   Message without sufficient indentation (ignored).
# @stderr Error output description.
# @stdin    three lines messages with list
#
#   - with trailing spaces    
#     - and sub list
#
#   which structure should be kept.
#
# @exitcode 0 Exit code section appears before stdin section.
test-stdin() {
}
EOF

tests:put expected <<EOF
# shdoc @stdin tests

Test @stdin functionnality.

## Overview

Tests for shdoc processing of @stdin keyword.

## Index

* [test-stdin](#test-stdin)

### test-stdin

test-stdin dummy function.

#### Exit codes

* **0**: Exit code section appears before stdin section.

#### Input on stdin

* simple one line message.
* one line message with indentation and trailing spaces.
* indented two lines message
  to test how indentation is trimmed.
* three lines messages with list
  
  - with trailing spaces    
    - and sub list
  
  which structure should be kept.

#### Output on stdout

* Stdout section appears after stdin section.

#### Output on stderr

* Error output description.

#### See also

* [see-also-after-stderr-section](#see-also-after-stderr-section)

EOF

assert
