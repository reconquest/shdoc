# shdoc

shdoc is a documentation generator for bash/zsh/sh for generating API documentation in Markdown from
shell scripts source.

shdoc parses [annotations](#features) in the beginning of a given file and alongside function
definitions, and creates a markdown file with ready to use documentation.

## Index

- [Index](#index)
- [Example](#example)
- [Features](#features)
  - [`@name`](#name)
  - [`@file`](#file)
  - [`@brief`](#brief)
  - [`@description`](#description)
  - [`@section`](#section)
  - [`@example`](#example-1)
  - [`@option`](#option)
  - [`@arg`](#arg)
  - [`@noargs`](#noargs)
  - [`@set`](#set)
  - [`@env`](#env)
  - [`@exitcode`](#exitcode)
  - [`@stdin`](#stdin)
  - [`@stdout`](#stdout)
  - [`@stderr`](#stderr)
  - [`@see`](#see)
  - [`@warning`](#warning)
  - [`@require`](#require)
  - [`@feature`](#feature)
  - [`@trap`](#trap)
  - [`@deprecated`](#deprecated)
  - [`@internal`](#internal)
- [Usage](#usage)
- [Installation](#installation)
  - [Arch Linux](#arch-linux)
  - [Using Git](#using-git)
  - [Others](#others)
- [Examples](#examples)

## Example

<table border="0">
 <tr>
    <td style="vertical-align: top">

Generate documentation with the following command:
~~~bash
$ shdoc < lib.sh > doc.md
~~~

_Source_ [examples/readme-example.sh](examples/readme-example.sh)<br />
_Output_: [examples/readme-example.md](examples/readme-example.md)<br/><br/>
~~~bash
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
~~~


</td>
<td>

~~~markdown
# libexample

A library that solves some common problems.

## Overview

The project solves lots of problems:
* a
* b
* c
* etc

## Index

* [say-hello](#say-hello)

### say-hello

[![Deprecated use yell-hello instead](https://img.shields.io/badge/Deprecated-use%20yell%2D%2Dhello%20instead-red.svg)](#)
[![Featuring Retry::default](https://img.shields.io/badge/Feature-Retry%3A%3A%3A%3Adefault-green.svg)](#)
[![1 Warning(s)](https://img.shields.io/badge/Warnings-1-yellow.svg)](#)

My super function.

#### Example

```bash
echo "test: $(say-hello World)"
```

#### Options

* **-h** | **--help**

  Display help.

* **-v\<value\>** | **--value=\<value\>**

  Set a value.

#### Arguments

* **$1** (string): A value to print

#### Environment variables

* **LANGUAGE** (string): provide this variable to translate hello world in given language (default value: en-GB)

#### Variables set

* **HELLO_HAS_BEEN_SAID** (int): set it to 1 if successful

#### Exit codes

* **0**: If successful.
* **1**: If an empty string passed.

#### Output on stdout

* Output 'Hello $1'.
  It hopes you say Hello back.

#### Output on stderr

* Output 'Oups !' on error.
  It did it again.

#### Requires

* ubuntu>20

#### Features

* Retry::default

#### Traps

* INT EXIT HUP QUIT ABRT TERM to manage temp files removal

#### Warnings

* Not thread-safe.

#### See also

* [validate()](#validate)
* [shdoc](https://github.com/reconquest/shdoc).

~~~

</td>
</tr></table>


## Features

### `@name`

A name of the project, used as a title of the doc. Can be specified once in the beginning of the
file.

**Example**

```bash
#!/bin/bash
# @name MyLibrary
```

### `@file`

Identical to [@name](#name).

### `@brief`

A brief line about the project. Can be specified once in the beginning of the file.<br>

**Example**
```bash
#!/bin/bash
# @brief A library to solve a few problems.
```

### `@description`

A multiline description of the project/section/function.
* Can be specified once for the whole file in the beginning of the file.
* Can be specified once for a section of the file. See [@section](#section).
* Can be specified once for on top of a function definition.

**Example**
```bash
#!/bin/bash
# @description A long description of the library.
# Second line of the project description.

# @description My super function.
# Second line of my super function description.
function super() {
    ...
}
```

### `@section`

The name of a section of the file. Can be used to group functions.

**Example**
```bash
# @section My utilities functions
# @description The following functions can be used to solve problems.
```

### `@example`

A multiline example of the function usage. Can be specified only alongside the function definition.

**Example**
```bash
# @example
#    echo "test: $(say-hello World)"
say-hello() {
    ...
}
```

The annotation accepts one argument to override default bash language
**Example**
```bash
# @example text
#    test: Hello World !
say-hello() {
    ...
}
```

### `@option`

A description of an option expected to be passed while calling the function.
Can be specified multiple times to describe any number of arguments.
If an option argument is expected, it must be specified between `<` and `>`

**Example**

```bash
# @description Says hi to a given person.
# @option -h A short option.
# @arg --value=<value> A long option with argument.
# @arg -v<value> | --value <value> A long option with short option alternative.
say-hello() {
    ...
}
```

### `@arg`

A description of an argument expected to be passed while calling the function.
Can be specified multiple times to describe any number of arguments.

**Example**

```bash
# @description Says hi to a given person.
# @arg $1 string A person's name.
# @arg $2 string Message priority.
say-hello() {
    ...
}
```

### `@noargs`

A note that the function does not expect any arguments to be passed.

**Example**

```bash
# @description Says 'hello world'.
# @noargs
say-hello-world() {
    ...
}
```

### `@set`

A description of a global variable that is set while calling the function.
Can be specified multiple times to describe any number of variables

**Example**

```bash
# @description Sets hello to the variable REPLY
# @set REPLY string Greeting message.
set-hello() {
    ...
}
```

### `@env`

A description of a global variable that is used during the call to this function.
Can be specified multiple times to describe any number of variables

**Example**

```bash
# @description Sets hello to the variable REPLY
# LANGUAGE string provide this variable to translate hello world in given language (default value: en-GB)
set-hello() {
    ...
}
```

### `@exitcode`

Describes an expected exitcode of the function.
Can be specified multiple times to describe all possible exitcodes and their conditions.

**Example**

```bash
# @description Says 'hello world'.
# @exitcode 0 If successful.
# @exitcode 1 If world is gone.
say-hello-world() {
    ...
}
```

### `@stdin`

The expected input to the function call from `stdin` (usually the terminal or command line)

**Example**

```bash
# @description Asks name.
# @stdin The users name from the terminal/command line.
say-hello-world() {
    ...
}
```

### `@stdout`

An expected output of the function call.

**Example**

```bash
# @description Says 'hello world'.
# @stdout A path to a temporary file with the message.
say-hello-world() {
    ...
}
```

### `@stderr`

An expected output of the function call on `/dev/stderr`.

**Example**

```bash
# @description Says 'hello world'.
# @stderr A error message when world is not available.
say-hello-world() {
    ...
}
```

### `@see`

Create a link on the given function in the "See Also" section.

**Example**

```bash
# @see say-hello
# @see text with [markdown link](./other-file#other-function)
say-hello-world() {
    ...
}
```

### `@warning`

Indicates some attention points related to the given function

**Example**

```bash
# @warning Performance : saying hello world to each people on Earth could lead to performance issues
say-hello-world() {
    ...
}
```

Note that a badge will also be generated before function description indicating the number of warnings

[![1 Warning(s)](https://img.shields.io/badge/Warnings-1-yellow.svg)](#warning)

### `@require`

Indicates some requirements needed by the given function

**Example**

```bash
# @require ubuntu>20
say-hello-world() {
    ...
}
```

### `@feature`

Indicates some special features used by the given function

**Example**

```bash
# @feature Retry::default
# @feature sudo
say-hello-world() {
    ...
}
```

### `@trap`

Indicates that traps are used by the given function

**Example**

```bash
# @trap INT EXIT HUP QUIT ABRT TERM to manage temp files removal
say-hello-world() {
    ...
}
```

### `@deprecated`

Indicates that the function is deprecated

**Example**

```bash
# @deprecated use yell-hello-world instead
say-hello-world() {
    ...
}
```

Note that a badge will also be generated before function description indicating the reason of the deprecation if specified

[![Deprecated use yell-hello-world instead](https://img.shields.io/badge/Deprecated-use%20yell--hello--world%20instead-red.svg)](#warning)

Or this simple badge if no reason is specified
[![Deprecated True](https://img.shields.io/badge/Deprecated-True-red.svg)](#warning)

### `@internal`

When you want to skip documentation generation for a particular function, you can specify this
`@internal` tag.
It allows you to have the same style of doc comments across the script and keep internal
functions hidden from users.

**Example**

```bash
# @internal
show-msg() {
    ...
}
```

## Usage

shdoc has no args and expects a shell script with comments on stdin and will produce markdown as stdout.

```bash
$ shdoc < your-shell-script.sh > doc.md
```

## Installation

### Arch Linux

Arch Linux users can install shdoc using package in AUR: [shdoc-git](https://aur.archlinux.org/packages/shdoc-git)

### Using Git

NOTE: shdoc requires gawk: `apt-get install gawk`

```bash
git clone --recursive https://github.com/reconquest/shdoc
cd shdoc
sudo make install
```

### Others

Unfortunately, there are no packages of shdoc for other distros, but we're looking for contributions.

## Examples

See example documentation on:

* [tests.sh](https://github.com/reconquest/tests.sh/blob/master/REFERENCE.md)
* [coproc.bash](https://github.com/reconquest/coproc.bash/blob/master/REFERENCE.md)

# LICENSE

MIT
