#!/bin/bash

tests:put input <<EOF
#!/bin/bash

# @arg \$1 string fn var.
# @stdout result of fn
function fn() {
    do fn
}

# @arg \$1 string spaces var.
# @stdout result of spaces
function   spaces() {
    do spaces
}

# @arg \$1 string tab1 var.
# @stdout result of tab1
function	tab1() {
    do tab1
}

# @arg \$1 string tab2 var.
# @stdout result of tab2
function	tab2()	{
    do tab2
}

# @arg \$1 string tab3 var.
# @stdout result of tab3
function	tab3()	{
    do tab3
}

# @arg \$1 string tab4 var.
# @stdout result of tab4
function	tab4	()	{
    do tab4
}
EOF

tests:put expected <<EOF
## Index

* [fn](#fn)
* [spaces](#spaces)
* [tab1](#tab1)
* [tab2](#tab2)
* [tab3](#tab3)
* [tab4](#tab4)

## fn

### Arguments

* **\$1** (string): fn var.

### Output on stdout

* result of fn

## spaces

### Arguments

* **\$1** (string): spaces var.

### Output on stdout

* result of spaces

## tab1

### Arguments

* **\$1** (string): tab1 var.

### Output on stdout

* result of tab1

## tab2

### Arguments

* **\$1** (string): tab2 var.

### Output on stdout

* result of tab2

## tab3

### Arguments

* **\$1** (string): tab3 var.

### Output on stdout

* result of tab3

## tab4

### Arguments

* **\$1** (string): tab4 var.

### Output on stdout

* result of tab4
EOF

assert
