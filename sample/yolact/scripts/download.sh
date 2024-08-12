# Define log levels with date
INFO=$(tput setaf 2; echo -n "[INFO] [$(date)]"; tput sgr0)
WARN=$(tput setaf 3; echo -n "[WARN] [$(date)]"; tput sgr0)
ERROR=$(tput setaf 1; echo -n "[ERROR] [$(date)]"; tput sgr0)

# Define colors
NOTE_INFO=$(tput setaf 6)

#!/bin/bash
pip3 install dfn

res=$(which unzip)
if [ $? != 0 ];
then
    echo "${INFO} Please install unzip on your system!"
    exit
fi

echo "${INFO} You has already installed unzip!"

scripts_dir=$(dirname $(readlink -f "$0"))
# echo $scripts_dir

pushd $scripts_dir > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
# datasets
if [ ! -d "../datasets" ]; 
then
    mkdir -p ../datasets

    python3 -m dfss --url=open@sophgo.com:sophon-demo/yolact/datasets.zip
    unzip datasets.zip -d ../datasets
    rm datasets.zip

    echo "${INFO} datasets download!"
else
    echo "${INFO} datasets exist!"
fi

# models
if [ ! -d "../models" ]; 
then
    mkdir -p ../models

    python3 -m dfss --url=open@sophgo.com:sophon-demo/yolact/models.zip
    unzip models.zip -d ../models
    rm models.zip

    echo "${INFO} models download!"
else
    echo "${INFO} models exist!"
fi
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
