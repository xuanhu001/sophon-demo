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
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv5/datasets_0918/datasets.zip
    unzip datasets.zip -d ../
    rm datasets.zip

    echo "${INFO} datasets download!"
else
    echo "${INFO} Datasets folder exist! Remove it if you need to update."
fi

# models
if [ ! -d "../models" ]; 
then
    mkdir -p ../models
    
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv10/tpu-mlir_v1.9.beta.0-116-g3c9d40a6d-20240720.tar.gz
    mv tpu-mlir_v1.9.beta.0-116-g3c9d40a6d-20240720.tar.gz  ../models

    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv10/BM1684X.zip
    # unzip BM1684X.zip -d ../models
    # rm BM1684X.zip

    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv10/BM1688.zip
    # unzip BM1688.zip -d ../models
    # rm BM1688.zip

    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv10/CV186X.zip
    # unzip CV186X.zip -d ../models
    # rm CV186X.zip

    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv10/onnx.zip
    unzip onnx.zip -d ../models
    rm onnx.zip

    echo "${INFO} models download!"
else
    echo "${INFO} Models folder exist! Remove it if you need to update."
fi
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"