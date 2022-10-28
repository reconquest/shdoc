#!/bin/bash
# @file libexample
# @brief A library that solves some common problems.
# @description
#     The project solves lots of problems:
#      * a
#      * b
#      * c
#      * etc

# @description My super function.
# Not thread-safe.
#
# @example
#    echo "test: $(say-hello World)"
#
# @arg $1 string A value to print
#
# @stdout Output 'Hello $1'.
# @stderr Output 'Oups !' on error.
#
# @exitcode 0 If successful.
# @exitcode 1 If an empty string passed.
#
# @see validate()
say-hello() {
    if [[ ! "$1" ]]; then
        echo "Oups !" >&2
        return 1;
    fi

    echo "Hello $1"
}
