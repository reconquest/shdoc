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

