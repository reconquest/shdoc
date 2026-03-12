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
#
# @option -h | --help Display help.
# @option -v<value> | --value=<value> Set a value.
#
# @arg $1 string A value to print
#
# @stdout Output 'Hello $1'.
#   It hopes you say Hello back.
# @stderr Output 'Oups !' on error.
#   It did it again.
#
# @exitcode 0 If successful.
# @exitcode 1 If an empty string passed.
#
# @see validate()
# @see [shdoc](https://github.com/reconquest/shdoc).
say-hello() {
    if [[ ! "$1" ]]; then
        echo "Oups !" >&2
        return 1;
    fi

    echo "Hello $1"
}

# @section Sub-section
# @description Some grouped functions.
# Sections allow a sub-set of other annotations and will ignore unsupported ones.
# @see README
# @example
#     # @section example
#     # @see [some-link](./README.md)
#     # @example ...

# @description This is nested
deeper-level() { echo; }

# @endsection

# @description Back up again
up-again() { echo; }