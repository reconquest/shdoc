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
# @warning Not thread-safe.
#
# @deprecated use yell-hello instead
#
# @require ubuntu>20
#
# @trap INT EXIT HUP QUIT ABRT TERM to manage temp files removal
#
# @feature Retry::default
# 
# @set HELLO_HAS_BEEN_SAID int set it to 1 if successful
#
# @env LANGUAGE string provide this variable to translate hello world in given language (default value: en-GB)
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