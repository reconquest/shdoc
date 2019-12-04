# shdoc

Converts comments to function to reference markdown documentation.

# Usage

shdoc expects a shell script in stdin and will produce markdown as stdout.

```
$ shdoc < your-shell-script.sh > doc.md
```

## Global Script tags

shdoc will match comments in the following form on top of a script file:
```sh
#!/bin/bash
#
# @file Title of file script
# @brief Small description of the script.
```

Will produce following output:

```markdown
# Title of file script

Small description of the script.
```

## Function tags

shdoc will match comments in the following form before function definitions:

```sh
# @description Multiline description goes here and
# there
#
# @example
#   some:other:func a b c
#   echo 123
#
# @arg $1 string Some arg.
# @arg $@ any Rest of arguments.
#
# @noargs
#
# @exitcode 0  If successfull.
# @exitcode >0 On failure
# @exitcode 5  On some error.
#
# @stdout Path to something.
#
# @see some:other:func()
some:first:func() {
```

`shdoc.awk` has no args and expects shell script with comments as described
above on the stdin and will markdown output result on the stdout.

Will produce following output:
````markdown

* [some:first:func()](#somefirstfunc)


## some:first:func()

Multiline description goes here and
there

### Example

```bash
some:other:func a b c
echo 123
```

### Arguments

* **$1** (string): Some arg.
* **...** (any): Rest of arguments.

_Function has no arguments._

### Exit codes

* **0**:  If successfull.
* **>0**: On failure
* **5**:  On some error.

### Output on stdout

* Path to something.

#### See also

* [some:other:func()](#some:other:func())
````

When you want to skip documentation generation for particular function, use `@internal` tag.
It allows you to have the same style of doc comments across the script and keep internal
functions hidden from users.

# Examples

See example documentation on:

* [tests.sh](https://github.com/reconquest/tests.sh/blob/master/REFERENCE.md)
* [coproc.bash](https://github.com/reconquest/coproc.bash/blob/master/REFERENCE.md)
