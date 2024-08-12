#!/bin/bash

# Define log levels with date
INFO=$(tput setaf 2; echo -n "[INFO] [$(date)]"; tput sgr0)
WARN=$(tput setaf 3; echo -n "[WARN] [$(date)]"; tput sgr0)
ERROR=$(tput setaf 1; echo -n "[ERROR] [$(date)]"; tput sgr0)

# Define colors
NOTE_INFO=$(tput setaf 6)

pip3 install dfss -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade
scripts_dir=$(dirname $(readlink -f "$0"))

pushd $scripts_dir > /dev/null
echo "${INFO} Changed directory to ${scripts_dir}"

# datasets
if [ ! -d "../datasets" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/SuperGlue/datasets.tar.gz
    tar xvf datasets.tar.gz -C ../ && rm datasets.tar.gz
    echo "${INFO} datasets downloaded!"
else
    echo "${WARN} Datasets folder exists! Remove it if you need to update."
fi

# models
if [ ! -d "../models" ]; 
then
    mkdir ../models
    pushd ../models > /dev/null
    echo "${INFO} Changed directory to ../models"
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/SuperGlue/models/BM1684X.tar.gz
    # tar xvf BM1684X.tar.gz && rm BM1684X.tar.gz
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/SuperGlue/models/BM1688.tar.gz
    # tar xvf BM1688.tar.gz && rm BM1688.tar.gz
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/SuperGlue/models/CV186X.tar.gz
    # tar xvf CV186X.tar.gz && rm CV186X.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/SuperGlue/models/onnx.tar.gz
    tar xvf onnx.tar.gz && rm onnx.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/SuperGlue/models/weights.tar.gz
    tar xvf weights.tar.gz && rm weights.tar.gz
    echo "${INFO} models downloaded!"
    popd > /dev/null
    echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
else
    echo "${WARN} Models folder exists! Remove it if you need to update."
fi

# cpp_dependencies
if [ ! -d "../cpp/libtorch" ]; 
then
    pushd ../cpp > /dev/null
    echo "${INFO} Changed directory to ../cpp"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/SuperGlue/libtorch.tar.gz
    tar xvf libtorch.tar.gz && rm libtorch.tar.gz
    popd > /dev/null
    echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    echo "${INFO} x86 libtorch downloaded!"
else
    echo "${WARN} libtorch folder exists! Remove it if you need to update."
fi

if [ ! -d "../cpp/aarch64_lib" ]; 
then
    pushd ../cpp > /dev/null
    echo "${INFO} Changed directory to ../cpp"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/SuperGlue/aarch64_lib.tar.gz
    tar xvf aarch64_lib.tar.gz && rm aarch64_lib.tar.gz
    popd > /dev/null
    echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    echo "${INFO} aarch64_lib downloaded!"
else
    echo "aarch64_lib folder exist! Remove it if you need to update."
fi

popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"