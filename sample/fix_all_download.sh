#!/bin/bash

# Define log levels with date
INFO=$(
    tput setaf 2
    echo -n "[INFO] [$(date)]"
    tput sgr0
)
WARN=$(
    tput setaf 3
    echo -n "[WARN] [$(date)]"
    tput sgr0
)
ERROR=$(
    tput setaf 1
    echo -n "[ERROR] [$(date)]"
    tput sgr0
)
NOTE_INFO=$(tput setaf 6)

# Find all download.sh files in subdirectories
for file in $(find ./RetinaFace/scripts -type f -name "download.sh"); do
    echo "${INFO} Processing ${file}"

    # Check if log levels and colors are already defined
    if ! grep -q "# Define log levels with date" $file; then
        # Add log levels and colors
        sed -i '1i # Define log levels with date\nINFO=$(tput setaf 2; echo -n "[INFO] [$(date)]"; tput sgr0)\nWARN=$(tput setaf 3; echo -n "[WARN] [$(date)]"; tput sgr0)\nERROR=$(tput setaf 1; echo -n "[ERROR] [$(date)]"; tput sgr0)\n\n# Define colors\nNOTE_INFO=$(tput setaf 6)\n' $file
        sed -i 's/echo "\(.*\)"/echo "${INFO} \1"/g' $file
    fi

    # Check if pushd and popd lines are already replaced
    if ! grep -q "pushd .* > \/dev\/null" $file; then
        # Replace pushd and popd lines
        sed -i 's/^\s*pushd \(.*\)/pushd \1 > \/dev\/null\necho "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"/g' $file
        sed -i 's/^\s*popd/popd > \/dev\/null\necho "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"/g' $file
    fi

    # Replace echo statements

    # perl -i -pe 's/echo "(?!${INFO}|${WARN}|${ERROR})(.*)"/echo "${INFO} \1"/g' $file
    # perl -i -pe "s/echo \"(?!${INFO}|${WARN}|${ERROR})(.*)\"/echo \"${INFO} \1\"/g" $file # 报错

    # INFO_ESCAPED=$(echo "${INFO}" | sed 's/\([][()]\)/\\\1/g')
    # WARN_ESCAPED=$(echo "${WARN}" | sed 's/\([][()]\)/\\\1/g')
    # ERROR_ESCAPED=$(echo "${ERROR}" | sed 's/\([][()]\)/\\\1/g')
    # perl -i -pe "s/echo \"(?!${INFO_ESCAPED}|${WARN_ESCAPED}|${ERROR_ESCAPED})(.*)\"/echo \"${INFO} \1\"/g" $file# 不行

    echo "${INFO} Updated ${file}"
done
