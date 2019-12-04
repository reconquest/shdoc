#!/bin/bash

tests:put input <<EOF
#!/bin/bash
#
# @file Title of file script
# @brief Small description of the script.
EOF

tests:put expected <<EOF
# Title of file script

Small description of the script.
EOF

assert
