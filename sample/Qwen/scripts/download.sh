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

# models
if [ ! -d "../models" ]; 
then
    mkdir -p ../models/
    mkdir -p ../models/BM1684X
pushd ../models/BM1684X > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Qwen/qwen-7b_int4_1dev.bmodel
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Qwen/qwen-7b_int8_1dev.bmodel
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    echo "${INFO} models download!"
else
    echo "${INFO} Models folder exist! Remove it if you need to update."
fi

if [ ! -d "../python/token_config" ];
then
pushd ../python > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Qwen/token_config.zip
    unzip token_config.zip
    rm token_config.zip
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
else
    echo "${INFO} token_config exists! Remove it if you need to update."
fi

popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"