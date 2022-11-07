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

#### Output on stdout

* Output 'Hello $1'.
  It hopes you say Hello back.

#### Output on stderr

* Output 'Oups !' on error.
  It did it again.

#### See also

* [validate()](#validate)
* Documentation generated using [shdoc](https://github.com/reconquest/shdoc).