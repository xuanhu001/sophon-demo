# Define log levels with date
INFO=$(tput setaf 2; echo -n "[INFO] [$(date)]"; tput sgr0)
WARN=$(tput setaf 3; echo -n "[WARN] [$(date)]"; tput sgr0)
ERROR=$(tput setaf 1; echo -n "[ERROR] [$(date)]"; tput sgr0)

# Define colors
NOTE_INFO=$(tput setaf 6)

#!/bin/bash
pip3 install dfss -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade

res=$(which unzip)
if [ $? != 0 ];
then
    echo "${INFO} Please install unzip on your system!"
    echo "${INFO} To install, use the following command:"
    echo "${INFO} sudo apt install unzip"
    exit
fi
res=$(which tar)
if [ $? != 0 ];
then
    echo "${INFO} Please install tar on your system!"
    echo "${INFO} To install, use the following command:"
    echo "${INFO} sudo apt install tar"
    exit
fi

scripts_dir=$(dirname $(readlink -f "$0"))
# echo $scripts_dir

pushd $scripts_dir > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"

# datasets
if [ ! -d "../datasets" ];
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv5/datasets_0918/datasets.zip
    unzip datasets.zip -d ../
    rm datasets.zip

    echo "${INFO} datasets download!"
else
    echo "${INFO} datasets exist!"
fi

# models
if [ ! -d "../models" ];
then
    mkdir -p ../models
    python3 -m dfss --url=open@sophgo.com:sophon-demo/ppYoloe/models.zip
    unzip models.zip -d ../models
    rm models.zip
pushd ../models/ > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/ppYoloe/models_20240416/BM1688.tgz
    # tar xvf BM1688.tgz
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/ppYoloe/models_20240416/CV186X.tgz
    # tar xvf CV186X.tgz
    # rm -r *.tgz
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    echo "${INFO} models download!"
else
    echo "${INFO} models exist!"
fi
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
