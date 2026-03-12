#!/bin/bash
# @file test/testcases/@optional-arguments.test.sh
# @author Pierre-Yves Landuré < contact at biapy dot fr >
# @brief Test cases for @option keyword with options.
# @description
#   Test these @option comportements:
#   - single dash short option (-o)
#   - single dash numeric short option (-2)
#   - double dash long option (--option)
#   - short option with value joined to letter.
#   - short option with value separated by space.
#   - long option with value separated by =.
#   - long option with value separated by space.
#   - long option with alternative short option syntax.
#   - appears before numeric argument list.
#   - appears between @example and @set sections.

tests:put input <<EOF
# @name shdoc @option tests for options
# @brief Test @option functionality for options.
# @description Tests for shdoc processing of @option keyword.

# @description documented test function
# @option -2 Run twice as fast.
# @option -h Show help message.
# @option --help Show help message.
# @option -h | --help Show help message.
# @option -v<my value> Set a value for short option (joined).
# @option -v <my value> Set a value for short option (space separated).
# @option option with invalid format.
# @option --value=<my value> Set a value for long option (= joined).
# @set ARG_TESTED A variable set by the function.
# @option ---another option with invalid format.
# @option --value <my value> Set a value for long option (space separated).
# @example
#   test-arg 'my-tested-argument'
#
# @option -v <my value> | --value <my value> Set a value.
# @option -v<my value> | --value=<my value> Set a value (joined).
# @option --value=<my value>  |  -v<my value> |   --longer-value <my value> Set a value via three different options.
# @arg -v<my value> | --value=<my value> Set a value described by @arg.
test-arg() {
}
EOF

tests:put expected <<EOF
# shdoc @option tests for options

Test @option functionality for options.

## Overview

Tests for shdoc processing of @option keyword.

## Index

* [test-arg](#test-arg)

## test-arg

documented test function

### Example

\`\`\`bash
test-arg 'my-tested-argument'
\`\`\`

### Options

* **-2**

  Run twice as fast.

* **-h**

  Show help message.

* **--help**

  Show help message.

* **-h** | **--help**

  Show help message.

* **-v\\<my value\\>**

  Set a value for short option (joined).

* **-v \\<my value\\>**

  Set a value for short option (space separated).

* **--value=\\<my value\\>**

  Set a value for long option (= joined).

* **--value \\<my value\\>**

  Set a value for long option (space separated).

* **-v \\<my value\\>** | **--value \\<my value\\>**

  Set a value.

* **-v\\<my value\\>** | **--value=\\<my value\\>**

  Set a value (joined).

* **--value=\\<my value\\>** | **-v\\<my value\\>** | **--longer-value \\<my value\\>**

  Set a value via three different options.

* **-v\\<my value\\>** | **--value=\\<my value\\>**

  Set a value described by @arg.

* option with invalid format.
* ---another option with invalid format.

### Variables set

* **ARG_TESTED** (A): variable set by the function.

EOF

assert
