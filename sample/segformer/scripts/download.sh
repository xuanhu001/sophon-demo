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

# Define colors
NOTE_INFO=$(tput setaf 6)

#!/bin/bash
res=$(which unzip)
if [ $? != 0 ]; then
    echo "${INFO} Please install unzip on your system!"
    exit
fi
pip3 install dfss -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade
script_dir=$(dirname $(readlink -f "$0"))
echo "${INFO} $script_dir"

pushd $script_dir >/dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"

# datasets
if [ ! -d "../datasets" ]; then
    mkdir -p ../datasets
    # test dataset
    # test input_test
    python3 -m dfss --url=open@sophgo.com:sophon-demo/segformer/datasets.zip
    unzip datasets.zip -d ../datasets
    rm datasets.zip
    echo "${INFO} datasets download!"
else
    echo "${INFO} datasets exist!"
fi

# models
if [ ! -d "../models" ]; then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/segformer/models.zip
    ls -al
    unzip models.zip -d ../
    rm models.zip
    echo "${INFO} models download!"
else
    echo "${INFO} models exist!"
fi

popd >/dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
