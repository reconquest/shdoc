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

