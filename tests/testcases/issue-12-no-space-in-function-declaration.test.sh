#!/bin/bash

tests:put input <<EOF
#!/bin/bash

# @description a desc for fn1
fn1() {
 return 0
}

# @description a desc for fn2
fn2(){
 return 0
}
EOF

tests:put expected <<EOF
## Index

* [fn1](#fn1)
* [fn2](#fn2)

## fn1

a desc for fn1

## fn2

a desc for fn2
EOF

assert
