#!/bin/bash

tests:put input <<EOF
#!/bin/bash
#
  # @file Title of file script %%VERSION%%
# @brief Small description of the script.
# @example
#   %%UNUSED%%
#   %%REPLACED%%

echo "%%UNTOUCHED%%"
EOF

tests:put expected <<EOF
# Title of file script 42

Small description of the script.

## Example

\`\`\`bash
%%UNUSED%%
example-text
\`\`\`

EOF

VERSION=42 REPLACED="example-text" UNTOUCHED="THIS IS NOT EXPECTED" assert
