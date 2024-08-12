# Define log levels with date
INFO=$(tput setaf 2; echo -n "[INFO] [$(date)]"; tput sgr0)
WARN=$(tput setaf 3; echo -n "[WARN] [$(date)]"; tput sgr0)
ERROR=$(tput setaf 1; echo -n "[ERROR] [$(date)]"; tput sgr0)

# Define colors
NOTE_INFO=$(tput setaf 6)

#!/bin/bash
res=$(which unzip)
if [ $? != 0 ]; then
    echo "${INFO} Please install unzip on your system!"
    echo "${INFO} Please run the following command: sudo apt-get install unzip"
    exit
fi
echo "${INFO} unzip is installed in your system!"

pip3 install dfss -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade

scripts_dir=$(dirname $(readlink -f "$0"))
pushd $scripts_dir > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"

# 检查 MiniCPM-2B-sft-bf16.zip 是否存在
if [ ! -d "../tools/MiniCPM-2B-sft-bf16" ];
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/MiniCPM/MiniCPM-2B-sft-bf16.zip
    unzip MiniCPM-2B-sft-bf16.zip -d ../tools/
    rm MiniCPM-2B-sft-bf16.zip
    echo "${INFO} MiniCPM-2B-sft-bf16 download!"
else
    echo "${INFO} tools/MiniCPM-2B-sft-bf16 folder exist! Remove it if you need to update."
fi

if [ ! -d "../models" ]; then
    mkdir -p ../models
fi

# 检查 BM1688文件夹 是否存在
if [ ! -d "../models/BM1688" ]; 
then
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/MiniCPM/BM1688.zip
    # unzip BM1688.zip -d ../models/
    # rm BM1688.zip
    echo "${INFO} BM1688 download!"
else
    echo "${INFO} BM1688 folder exist! Remove it if you need to update."
fi

# 检查 CV186X 文件夹 是否存在
if [ ! -d "../models/CV186X" ]; 
then
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/MiniCPM/CV186X.zip
    # unzip CV186X.zip -d ../models/
    # rm CV186X.zip
    echo "${INFO} CV186X download!"
else
    echo "${INFO} CV186X folder exist! Remove it if you need to update."
fi

# 检查 BM1684X文件夹 是否存在
if [ ! -d "../models/BM1684X" ]; 
then
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/MiniCPM/BM1684X.zip
    # unzip BM1684X.zip -d ../models/
    # rm BM1684X.zip
    echo "${INFO} BM1684X download!"
else
    echo "${INFO} BM1684X folder exist! Remove it if you need to update."
fi

# 检查 lib_pcie文件夹 是否存在
if [ ! -d "../cpp/lib_pcie" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/MiniCPM/lib_pcie.zip
    unzip lib_pcie.zip -d ../cpp/
    rm lib_pcie.zip
    echo "${INFO} lib_pcie download!"
else
    echo "${INFO} lib_pcie folder exist! Remove it if you need to update."
fi

# 检查 lib_soc_bm1684x文件夹 是否存在
if [ ! -d "../cpp/lib_soc_bm1684x" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/MiniCPM/lib_soc_bm1684x.zip
    unzip lib_soc_bm1684x.zip -d ../cpp/
    rm lib_soc_bm1684x.zip
    echo "${INFO} lib_soc_bm1684x download!"
else
    echo "${INFO} lib_soc_bm1684x folder exist! Remove it if you need to update."
fi

# 检查 lib_soc_bm1688文件夹 是否存在
if [ ! -d "../cpp/lib_soc_bm1688" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/MiniCPM/lib_soc_bm1688.zip
    unzip lib_soc_bm1688.zip -d ../cpp/
    rm lib_soc_bm1688.zip
    echo "${INFO} lib_soc_bm1688 download!"
else
    echo "${INFO} lib_soc_bm1688 folder exist! Remove it if you need to update."
fi

# 检查 lib_soc_cv186x文件夹 是否存在
if [ ! -d "../cpp/lib_soc_cv186x" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/MiniCPM/lib_soc_cv186x.zip
    unzip lib_soc_cv186x.zip -d ../cpp/
    rm lib_soc_cv186x.zip
    echo "${INFO} lib_soc_cv186x download!"
else
    echo "${INFO} lib_soc_cv186x folder exist! Remove it if you need to update."
fi

# 检查 token_config文件夹 是否存在
if [ ! -d "../cpp/token_config" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/MiniCPM/token_config.zip
    unzip token_config.zip -d ../cpp/
    rm token_config.zip
    echo "${INFO} token_config download!"
else
    echo "${INFO} token_config folder exist! Remove it if you need to update."
fi

popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"

