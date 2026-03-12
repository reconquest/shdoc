# shdoc

shdoc is a documentation generator for bash/zsh/sh for generating API documentation in Markdown from
shell scripts source.

shdoc parses [annotations](#features) in the beginning of a given file and alongside function definitions, and creates a markdown file with ready to use documentation.  
This fork adds a few features and bugfixes to the upstream at [reconquest/shdoc](https://github.com/reconquest/shdoc). Features specific to this fork will be marked accordingly.

## Index

* [Usage](#usage)
* [Example](#example)
* [Annotations](#features)
* [Installation](#installation)
* [License](#license)

## Usage

shdoc has no args and expects a shell script with comments on stdin and will produce markdown as stdout.

```bash
$ shdoc < your-shell-script.sh > doc.md
```

## Example

Generate documentation with the following command:

~~~bash
$ shdoc < lib.sh > doc.md
~~~

The table below shows the result for the following files:  
_Source_: [examples/readme-example.sh](examples/readme-example.sh)<br />
_Output_: [examples/readme-example.md](examples/readme-example.md)<br/><br/>

<table border="0">
 <tr>
    <td style="vertical-align: top">

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
* [Sub-section](#sub-section)
  * [deeper-level](#deeper-level)
* [up-again](#up-again)

## say-hello

My super function.
Not thread-safe.

### Example

```bash
echo "test: $(say-hello World)"
```

### Options

* **-h** | **--help**

  Display help.

* **-v\<value\>** | **--value=\<value\>**

  Set a value.

### Arguments

* **$1** (string): A value to print

### Exit codes

* **0**: If successful.
* **1**: If an empty string passed.

### Output on stdout

* Output 'Hello $1'.
  It hopes you say Hello back.

### Output on stderr

* Output 'Oups !' on error.
  It did it again.

### See also

* [validate()](#validate)
* [shdoc](https://github.com/reconquest/shdoc).

## Sub-section

Some grouped functions.
Sections allow a sub-set of other annotations and will ignore unsupported ones.

### Example

```bash
# @section example
# @see [some-link](./README.md)
# @example ...
```

### See also

* [README](#readme)

### deeper-level

This is nested

## up-again

Back up again

~~~

</td>
</tr></table>


## Features

### `@name`

A name of the project, used as a title of the doc. Can be specified once in the beginning of the
file.

**Note:**  
A comment block linked to `@name` or `@file` must be followed by at least one none-comment line 
after its `@description` and other annotations, or it will not be recognized correctly.
correctly.

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

The name of a section of the file. Can be used to group functions. Creates a paragraph titled with the section name.  
All functions following this annotation will be placed as sub-paragraphs of the given section.
Use again to start the next section or `@endsection` to break out of the current section.  
`@section` blocks need to be followed by at least one none-comment none-EOF line to be printed.

**fork-specific**
- The sections will also appear in the TOC.
- `@section` influences the header level used for function description titles. 
    1. When a section is active, function headers will use `###`, the section header itself uses `##`.
    2. After `@endsection` has been encountered, or before and `@section` annotation, functions will use `##`.
    3. The nesting will also be reflected in the TOC.

**Example**
```bash
# @section My utilities functions
# @description The following functions can be used to solve problems.

# @description sub-function
func-in-section() { ... }
```

### `@endsection`

**This annotation is fork-specific**  
When `@section` is used, shdoc can not by itself detect the end of a section. It would assume the remaining script to be on a deeper nested level and only ever insert subsequent section titles in-between.  
This annotation can be used to disable the grouping again for the following functions. It has no effect on its own. Captions for functions contained in sections are level 3 (`###`), 
ungrouped functions are level 2 (`##`).

**original:**  
In the original, there is no termination marker for `@section` and no adjustment of header levels depending on section nesting. There, all functions are always level 3, sections are level 2 and section descriptions
are inserted in-between. So there is no visible distinction between function descriptions contained in a section and others not contained. In fact, once a `@section` was specified, everything following it 
appears as if it is contained in that.

**Example**
```bash
# @section First group
# @description Logical group

# @description
some-group() { ... }

# @endsection

# @description something not grouped
important-top-level() { ... }

# @section
# @description another sub-group
```

### `@example`

A multiline example of the function usage. Can be specified only alongside the function and section definitions.  
Must be followed by an empty line if other annotations shall be used after it in the same block. Without the empty line,
the annotation would instead be put into the example.

**fork-specific**: Also works for `@section` and `@file`.

**Example**
```bash
# @example
#    echo "test: $(say-hello World)"
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
# @option --value=<value> A long option with argument.
# @option -v<value> | --value <value> A long option with short option alternative.
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
Can be specified multiple times to describe any number of variables.

**fork-specific**: Also works for `@section` and `@file`.

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

**fork-specific**: Also works for `@section` and `@file`.

**Example**

```bash
# @see say-hello
# @see text with [markdown link](./other-file#other-function)
say-hello-world() {
    ...
}
```

### `@internal`

When you want to skip documentation generation for a particular function, you can specify this `@internal` tag.
It allows you to have the same style of doc comments across the script and keep internal functions hidden from users.

**fork-specific:**  
When used in `@section` blocks, all functions until the next `@endsection` or `@section` will be considered internal.  

**Example**

```bash
# @internal
show-msg() {
    ...
}
```

## Advanced features

**fork-specific**

This section describes advanced features and capabilities which are not necessarily needed for simple function documentation.

### Literal MD source lines

By default, `shdoc` performs whitespace trimming at the start of a comment line while it builds description blocks.  
This behavior disables the possibility to use formatting options like code blocks by indentation (4 spaces), or use 
pre-formatted (and indented) text within fenced code blocks (`~~~` or ` ``` `).

It is possible to disable the trimming behavior by using `#|` as comment prefix, instead of just `# ` (as for annotations). 
`shdoc` will only consume the beginning of the line matching the regex `[ ]*#|` and leave the rest untouched.  
**Note:** This behaviour has implications for lines where tables are declared.

**Examples**

- Simple
<table>
 <tr>
  <th>Input</th>
  <th>Result</th>
 </tr>
  <tr>
  <td>
   
```bash
# @description Simple
#| This is kept literally...
#|                       ... this too
#        me too... not.
```

  </td>
  <td>
   
```md
Simple
 This is kept literally...
                       ... this too
me too... not.
```

  </td>
 </tr>
</table>

- Tables  
**Note:** In MD itself, there is little reason to indenting a table. Instead, indenting it too far would convert the table into a code block instead,
where the table source code is not processed as MD.  
The literal md marker does not perform any extra checks to find out wether the pipe contained in `#|` is part of the table or not. The pipe character
connected to the comment hash will be stripped. As a consequence, writing tables requires a space between `#` and the left beginning `|` for regular
tables. Alternatively, if the table code should really be indented, 2 pipes must be used, with spaces in between.

<table>
  <tr>
    <th>Input</th>
    <th>Result</th>
  </tr>
  <tr>
    <td>
   
```bash
# @description Table
#| co1 | co2 |
#      | abc | def |
#| | 123 | 456 |
#|     | 123 | 456 |
```

  </td>
  <td>

```md
Table
 co1 | co2 |
| abc | def |
 | 123 | 456 |
     | 123 | 456 |
```

  </td>
</tr>
</table>


Takeaway: 
1. If (for optical reasons only) you want to indent a table, don't use `#|`.
2. For regular tables, keep at least one space between `#` and `|` at the beginning of the line
3. Indenting table source requires `#|`, followed by the desired amount of spaces, then `|` to start the table row.

### Parameter support

`shdoc` can perform simple parameter replacement. It will recognize replacement tags in the form `%%<varname>%%` and 
try to retrieve the value of an equally-named environment variable `<varname>`. If any value is found, the entire tag
is replaced. The tag is left untouched otherwise.

This allows the documentation source comments to work like a simple template

**Rules:**
- Only tags in comment blocks are recognized (lines starting with `[[:space:]]*#`).
- Tag replacement happens first, before any other processing is done. This allows to place annotations in tags.
- Multiple tags can be replaced per line (identical and different ones), but they will not be resolved recursively.  
  **Exception:** Tags are looped over in the order of definition. When the content of the first tag resolves to a
  subsequent tag name, then this subsequent tag will be replaced in a later iteration.
- `<varname>` must be a valid name for a shell environment variable, consisting of `[a-Z0-9-_]+`.
- `shdoc` does not perform any parameter expansion.
- There is no way to 'mask' or 'quote' a tag, if it matches the form above.
- Example blocks or sections fenced in backticks or quotes are neither recognized, not treated specially.

## Installation

### Arch Linux

Arch Linux users can install shdoc using package in AUR: [shdoc-git](https://aur.archlinux.org/packages/shdoc-git)

**Note:**  
The package in AUR installs the original version [reconquest/shdoc](https://github.com/reconquest/shdoc). This fork does not have a package.  
However, shdoc itself is a single script file, it can just be downloaded directly from the repository.

### Using Git

NOTE: shdoc requires gawk: `apt-get install gawk`

```bash
git clone --recursive https://github.com/GB609/shdoc
cd shdoc
sudo make install
```

### Others

There are no packages of shdoc for other distros.

# LICENSE

MIT
