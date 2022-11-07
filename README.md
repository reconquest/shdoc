# shdoc

shdoc is a documentation generator for bash/zsh/sh for generating API documentation in Markdown from
shell scripts source.

shdoc parses [annotations](#features) in the beginning of a given file and alongside function
definitions, and creates a markdown file with ready to use documentation.

## Index

* [Example](#example)
* [Annotations](#annotations)
* [Usage](#usage)
* [Installation](#installation)
* [More examples](#examples)
* [License](#license)

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
# Not thread-safe.
#
# @example
#    echo "test: $(say-hello World)"
#
# @arg $1 string A value to print
#
# @exitcode 0 If successful.
# @exitcode 1 If an empty string passed.
#
# @see validate()
say-hello() {
    if [[ ! "$1" ]]; then
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

My super function.
Not thread-safe.

#### Example

```bash
echo "test: $(say-hello World)"
```

#### Arguments

* **$1** (string): A value to print

#### Exit codes

* **0**: If successful.
* **1**: If an empty string passed.

#### See also

* [validate()](#validate)
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
