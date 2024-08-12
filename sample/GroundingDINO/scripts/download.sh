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

    python3 -m dfss --url=open@sophgo.com:sophon-demo/GroundingDINO/datasets.zip
    unzip datasets.zip -d ../datasets
    rm datasets.zip

    echo "${INFO} datasets download!"
else
    echo "${INFO} datasets exist!"
fi

# models
if [ ! -d "../models" ]; 
then
    mkdir ../models
    python3 -m dfss --url=open@sophgo.com:sophon-demo/GroundingDINO/models.zip
    unzip models.zip -d ../models
    rm models.zip

    python3 -m dfss --url=open@sophgo.com:sophon-demo/GroundingDINO/tpu-mlir_v1.9.beta.0-89-g009410603-20240715.tar.gz
    mv tpu-mlir_v1.9.beta.0-89-g009410603-20240715.tar.gz ../models

    python3 -m dfss --url=open@sophgo.com:sophon-demo/GroundingDINO/bert-base-uncased.zip
    unzip bert-base-uncased.zip -d ../models
    rm bert-base-uncased.zip

    python3 -m dfss --url=open@sophgo.com:sophon-demo/GroundingDINO/onnx.zip
    unzip onnx.zip -d ../models
    rm onnx.zip

    # python3 -m dfss --url=open@sophgo.com:sophon-demo/GroundingDINO/bm1688_cv186x/BM1688.zip
    # unzip BM1688.zip -d ../models
    # rm BM1688.zip

    # python3 -m dfss --url=open@sophgo.com:sophon-demo/GroundingDINO/bm1688_cv186x/CV186X.zip
    # unzip CV186X.zip -d ../models
    # rm CV186X.zip

    echo "${INFO} models download!"
else
    echo "${INFO} models exist!"
fi
