#!/bin/bash

tests:put input <<EOF
# @description Multiline description goes here and
# there
#
# @example
#   some:other:func a b c
#   echo 123
#
# @warning Performance : for multiple values to remove, prefer using some:second:func
# @deprecated use some:second:func instead
# @require ubuntu>20
# @trap INT EXIT HUP QUIT ABRT TERM to manage temp files removal
# @feature Retry::default
# @feature sudo
some:first:func() {
EOF

tests:put expected <<EOF
## Index

* [some:first:func](#somefirstfunc)

### some:first:func

[![Deprecated use some:second:func instead](https://img.shields.io/badge/Deprecated-use%20some%3A%3Asecond%3A%3Afunc%20instead-red.svg)](#)
[![Featuring Retry::default](https://img.shields.io/badge/Feature-Retry%3A%3A%3A%3Adefault-green.svg)](#)
[![Featuring sudo](https://img.shields.io/badge/Feature-sudo-green.svg)](#)
[![1 Warning(s)](https://img.shields.io/badge/Warnings-1-yellow.svg)](#)

Multiline description goes here and
there

#### Example

\`\`\`bash
some:other:func a b c
echo 123
\`\`\`

#### Requires

* ubuntu>20

#### Features

* Retry::default
* sudo

#### Traps

* INT EXIT HUP QUIT ABRT TERM to manage temp files removal

#### Warnings

* Performance : for multiple values to remove, prefer using some:second:func
EOF

assert
