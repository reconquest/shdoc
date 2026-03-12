# Make an entire section internal.
# None of its functions should appear in doc or toc.
# The section itself also shouldn't appear.
# Internal flag should be cleared by starting a next section, or ending the current one.

tests:put input <<EOF
# @name Project Name
# @description Testing @internal on sections...

# @section Section A
# @description line 1
# line 2
# @internal

# @description implicitely internal 1
internal-a() {
}

# @description implicitely internal 2
internal-b() {
  
}

# @section Must be visible
# @description Resets internal flag by @section

# @description must be visible
b-visible() {
}

# @section Another internal section
# @description terminated by @endsection
# @internal

not-visible() {
}

# @endsection

visible() {
}

# @section public section
# @description with function

# @description must be visible
visible-in-section() {
}

# @endsection

EOF

tests:put expected <<EOF
# Project Name

## Overview

Testing @internal on sections...

## Index

* [Must be visible](#must-be-visible)
  * [b-visible](#b-visible)
* [public section](#public-section)
  * [visible-in-section](#visible-in-section)

## Must be visible

Resets internal flag by @section

### b-visible

must be visible

## public section

with function

### visible-in-section

must be visible
EOF

assert
