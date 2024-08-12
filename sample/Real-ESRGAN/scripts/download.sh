# Define log levels with date
INFO=$(tput setaf 2; echo -n "[INFO] [$(date)]"; tput sgr0)
WARN=$(tput setaf 3; echo -n "[WARN] [$(date)]"; tput sgr0)
ERROR=$(tput setaf 1; echo -n "[ERROR] [$(date)]"; tput sgr0)

# Define colors
NOTE_INFO=$(tput setaf 6)

#!/bin/bash
res=$(which unzip)
if [ $? != 0 ];
then
    echo "${INFO} Please install unzip on your system!"
    exit
fi
pip3 install dfss -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade
scripts_dir=$(dirname $(readlink -f "$0"))

pushd $scripts_dir > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
# datasets
if [ ! -d "../datasets" ]; 
then
    mkdir ../datasets
pushd ../datasets > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"

    python3 -m dfss --url=open@sophgo.com:sophon-demo/common/coco128.tgz
    tar xvf coco128.tgz

popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    echo "${INFO} datasets download!"
else
    echo "${INFO} Datasets folder exist! Remove it if you need to update."
fi

# models
if [ ! -d "../models" ]; 
then
    mkdir ../models
pushd ../models > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    
    mkdir onnx
pushd onnx > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Real-ESRGAN/models/realesr-general-x4v3.onnx
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/Real-ESRGAN/models/BM1688.tgz
    # tar xvf BM1688.tgz

    # python3 -m dfss --url=open@sophgo.com:sophon-demo/Real-ESRGAN/models/BM1684X.tgz
    # tar xvf BM1684X.tgz

    # python3 -m dfss --url=open@sophgo.com:sophon-demo/Real-ESRGAN/models/CV186X.tgz
    # tar xvf CV186X.tgz
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"    
    echo "${INFO} models download!"
else
    echo "${INFO} Models folder exist! Remove it if you need to update."
fi
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"