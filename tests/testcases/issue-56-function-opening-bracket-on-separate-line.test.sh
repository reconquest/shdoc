#!/bin/bash

tests:put input <<EOF
#!/sbin/sh

# @description My super function.
#
# @arg \$1 string A value to print
say-hello()
{
    if [[ ! "\$1" ]]; then
        return 1;
    fi

    echo "Hello \$1"
}

EOF

tests:put expected <<EOF
## Index

* [say-hello](#say-hello)

## say-hello

My super function.

### Arguments

* **\$1** (string): A value to print

EOF

assert
