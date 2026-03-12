#!/bin/bash
# @file test/testcases/@numbered-arguments.test.sh
# @author Pierre-Yves Landuré < contact at biapy dot fr >
# @brief Test cases for @arg keyword.
# @description
#   Test these @arg comportements:
#   - arg numbers in disorder.
#   - arg numbers > 10
#   - arg message with indentation and trailing spaces.
#   - appears between @example and @set sections.

tests:put input <<EOF
# @name shdoc @arg tests
# @brief Test @arg functionality.
# @description Tests for shdoc processing of @arg keyword.

# @description The test function
# @arg \$4 int 4th arg.
# @arg \$6 string 6th arg.
# @set ARG_TESTED A variable set by the function.
# @arg \$5 int 5th arg.
# @arg \$@ string All other arguments.
# @arg \$1 string 1st arg.
# @example
#   test-arg 'my-tested-argument'
#
# @arg \$3    bool    3rd arg with indentation and trailing spaces.        
# @arg \$2 string 2nd arg.
    # @arg \$7 string 7th arg with indentation before #.
#       @arg \$8 array[] 8th arg with indentation between # and @arg.
# @arg      \$9 string 9th arg with indentation between @arg and number.
# @arg \$10 string 10th arg.
# @arg \$11 string 11th arg.
test-arg() {
}
EOF

tests:put expected <<EOF
# shdoc @arg tests

Test @arg functionality.

## Overview

Tests for shdoc processing of @arg keyword.

## Index

* [test-arg](#test-arg)

## test-arg

The test function

### Example

\`\`\`bash
test-arg 'my-tested-argument'
\`\`\`

### Arguments

* **\$1** (string): 1st arg.
* **\$2** (string): 2nd arg.
* **\$3** (bool): 3rd arg with indentation and trailing spaces.
* **\$4** (int): 4th arg.
* **\$5** (int): 5th arg.
* **\$6** (string): 6th arg.
* **\$7** (string): 7th arg with indentation before #.
* **\$8** (array[]): 8th arg with indentation between # and @arg.
* **\$9** (string): 9th arg with indentation between @arg and number.
* **\$10** (string): 10th arg.
* **\$11** (string): 11th arg.
* **...** (string): All other arguments.

### Variables set

* **ARG_TESTED** (A): variable set by the function.

EOF

assert
