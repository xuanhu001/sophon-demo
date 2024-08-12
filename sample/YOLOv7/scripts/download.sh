# Define log levels with date
INFO=$(tput setaf 2; echo -n "[INFO] [$(date)]"; tput sgr0)
WARN=$(tput setaf 3; echo -n "[WARN] [$(date)]"; tput sgr0)
ERROR=$(tput setaf 1; echo -n "[ERROR] [$(date)]"; tput sgr0)

# Define colors
NOTE_INFO=$(tput setaf 6)

#!/bin/bash
res=$(which 7z)
if [ $? != 0 ];
then
    echo "${INFO} Please install 7z on your system!"
    echo "${INFO} To install, use the following command:"
    echo "${INFO} sudo apt install p7zip;sudo apt install p7zip-full"
    exit
fi

pip3 install dfss -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade

scripts_dir=$(cd `dirname $BASH_SOURCE[0]`/ && pwd)

pushd ${scripts_dir} > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"

# datasets
if [ ! -d "../datasets" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv7/datasets.7z
    7z x datasets.7z -o../
    rm datasets.7z
    echo "${INFO} datasets download!"
else
    echo "${INFO} datasets exist! Remove it if you need to update."
fi

# models
if [ ! -d "../models" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv7/models.7z
    7z x models.7z -o../
    rm models.7z
pushd ../models/ > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv7/BM1688.7z
    # 7z x BM1688.7z  
    # rm -r BM1688.7z
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv7/CV186X.7z
    # 7z x CV186X.7z  
    # rm -r CV186X.7z
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    echo "${INFO} models download!"
else
    echo "${INFO} models exist! Remove it if you need to update."
fi
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"