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
    python3 -m dfss --url=open@sophgo.com:sophon-demo/PP-OCR/datasets_0918/datasets.zip
    unzip datasets.zip -d ../
    rm datasets.zip

    echo "${INFO} datasets download!"
else
    echo "${INFO} Datasets folder exist! Remove it if you need to update."
fi

# models
if [ ! -d "../models" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/PP-OCR/models_0918/models.zip
    unzip models.zip -d ../
    rm models.zip
    rm ../models/BM1684/ch_PP-OCRv3_*_int8.bmodel ../models/BM1684X/ch_PP-OCRv3_*_int8.bmodel #int8 has bad performance, if you want to test it, you can comment this line
pushd ../models/ > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/PP-OCR/models_231220/BM1688.zip
    # unzip BM1688.zip
    # rm -r BM1688.zip
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/PP-OCR/models_240412/CV186X.zip
    # unzip CV186X.zip
    # rm -r CV186X.zip
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    echo "${INFO} models download!"
else
    echo "${INFO} Models folder exist! Remove it if you need to update."
fi
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"