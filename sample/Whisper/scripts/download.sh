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
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Whisper/datasets_240327/datasets.zip
    unzip datasets.zip -d ../
    rm datasets.zip

    echo "${INFO} datasets download!"
else
    echo "${INFO} Datasets folder exist! Remove it if you need to update."
fi

# models
if [ ! -d "../models" ];
then
    mkdir ../models
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Whisper/model_240408/bmodel.zip
    unzip bmodel.zip -d ../models
    rm bmodel.zip
    echo "${INFO} bmodel download!"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Whisper/model_240408/onnx.zip
    unzip onnx.zip -d ../models
    rm onnx.zip
    echo "${INFO} onnx models download!"
else
    echo "${INFO} Models folder exist! Remove it if you need to update."
fi
# assets
if [ ! -d "../python/bmwhisper/assets" ];
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Whisper/model_240408/assets.zip
    unzip assets.zip -d ../python/bmwhisper
    rm assets.zip
    echo "${INFO} assets download!"
else
    echo "${INFO} Assets folder exist! Remove it if you need to update."
fi
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"