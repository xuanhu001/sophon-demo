#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Get the list of directories in the current path and sort them by name
directories=$(find . -maxdepth 1 -type d | LC_ALL=C sort)

# Iterate over each directory
for dir in $directories; do
    # Check if the directory contains a "models" folder
    if [ -d "$dir/models" ]; then
        # Check if the "models" folder is empty
        if [ "$(ls -A $dir/models)" ]; then
            # Remove the specified directories from the "models" folder
            rm -rf "$dir/models/BM1684X" "$dir/models/BM1688" "$dir/models/CV186X"

            # Get the size of the "models" folder
            size=$(du -sh "$dir/models" | awk '{print $1}')
            # Print the directory name and the size of the "models" folder
            echo -e "[${GREEN}INFO ${NC}] Directory: ${YELLOW}$dir${NC}, Models folder size: $size"
        fi
    else
        # Print error message if "models" folder is not found
        # echo -e "[${RED}ERROR${NC}] Directory: ${YELLOW}$dir${NC}, Models folder not found"
        # 不输出
        :
    fi
done#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Get the list of directories in the current path and sort them by name
directories=$(find . -maxdepth 1 -type d | LC_ALL=C sort)

# Iterate over each directory
for dir in $directories; do
    # Check if the directory contains a "models" folder
    if [ -d "$dir/models" ]; then
        # Remove the specified directories from the "models" folder
        rm -rf "$dir/models/BM1684X" "$dir/models/BM1688" "$dir/models/CV186X"

        # Get the size of the "models" folder
        size=$(du -sh "$dir/models" | awk '{print $1}')
        # Print the directory name and the size of the "models" folder
        echo -e "[${GREEN}INFO ${NC}] Directory: ${YELLOW}$dir${NC}, Models folder size: $size"
    else
        # Print error message if "models" folder is not found
        # echo -e "[${RED}ERROR${NC}] Directory: ${YELLOW}$dir${NC}, Models folder not found"
        # 不输出
        :
    fi
done