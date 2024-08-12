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
    mkdir -p ../datasets
    python3 -m dfss --url=open@sophgo.com:sophon-demo/WeNet/datasets/aishell_S0764.zip
    unzip aishell_S0764.zip -d ../datasets
    rm aishell_S0764.zip

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
    python3 -m dfss --url=open@sophgo.com:sophon-demo/WeNet/models/BM1684.tar.gz
    tar xvf BM1684.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/WeNet/models/BM1684X.tar.gz
    tar xvf BM1684X.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/WeNet/models/BM1688.tar.gz
    tar xvf BM1688.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/WeNet/models/CV186X.tar.gz
    tar xvf CV186X.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/WeNet/models/onnx.tar.gz
    tar xvf onnx.tar.gz
    rm -r *.tar.gz
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    echo "${INFO} models download!"
else
    echo "${INFO} Models folder exist! Remove it if you need to update."
fi

if [ ! -d "../cpp/cross_compile_module" ];
then
    mkdir -p ../cpp/cross_compile_module
pushd ../cpp/cross_compile_module > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/WeNet/soc/3rd_party.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/WeNet/soc/ctcdecode-cpp.tar.gz
    tar zxf 3rd_party.tar.gz
    tar zxf ctcdecode-cpp.tar.gz
    rm 3rd_party.tar.gz
    rm ctcdecode-cpp.tar.gz
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    echo "${INFO} cross_compile_module download!"
else
    echo "${INFO} cross_compile_module exist, please remove it if you want to update."
fi

if [ ! -d "../cpp/ctcdecode-cpp" ];
then
pushd ../cpp > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/WeNet/pcie/ctcdecode-cpp.tar.gz
    tar xvf ctcdecode-cpp.tar.gz
    rm ctcdecode-cpp.tar.gz
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
else
    echo "${INFO} ctcdecode-cpp exist, please remove it if you want to update."
fi

# swig decoders module
if [ ! -d "../python/swig_decoders_aarch64" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/WeNet/soc/swig_decoders_aarch64.zip
    unzip swig_decoders_aarch64.zip -d ../python/
    rm swig_decoders_aarch64.zip
    echo "${INFO} swig_decoders_aarch64 download!"
else
    echo "${INFO} swig_decoders_aarch64 exist, please remove it if you want to update."
fi

if [ ! -d "../python/swig_decoders_x86_64" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/WeNet/pcie/swig_decoders_x86_64.zip
    unzip swig_decoders_x86_64.zip -d ../python/
    rm swig_decoders_x86_64.zip
    echo "${INFO} swig_decoders_x86_64 download!"
else
    echo "${INFO} swig_decoders_x86_64 exist, please remove it if you want to update."
fi



popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"