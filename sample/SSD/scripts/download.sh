# Define log levels with date
INFO=$(tput setaf 2; echo -n "[INFO] [$(date)]"; tput sgr0)
WARN=$(tput setaf 3; echo -n "[WARN] [$(date)]"; tput sgr0)
ERROR=$(tput setaf 1; echo -n "[ERROR] [$(date)]"; tput sgr0)

# Define colors
NOTE_INFO=$(tput setaf 6)

#!/bin/bash

# Define log levels with date
INFO=$(tput setaf 2; echo -n "[INFO] [$(date)]"; tput sgr0)
WARN=$(tput setaf 3; echo -n "[WARN] [$(date)]"; tput sgr0)
ERROR=$(tput setaf 1; echo -n "[ERROR] [$(date)]"; tput sgr0)

# Define colors
NOTE_INFO=$(tput setaf 6)

res=$(which unzip)
if [ $? != 0 ];
then
    echo "${ERROR} Please install unzip on your system!"
    exit
fi
scripts_dir=$(dirname $(readlink -f "$0"))
# pip3 install dfss -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade
pushd $scripts_dir > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$scripts_dir"
if [ ! -d "../data" ];
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/SSD/data.zip
    unzip data.zip -d ../
    rm data.zip
    echo "${INFO} Data downloaded and extracted!"
else
    echo "${WARN} Data already exists, skipping download!"
fi
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"