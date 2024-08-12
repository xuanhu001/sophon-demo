# Define log levels with date
INFO=$(tput setaf 2; echo -n "[INFO] [$(date)]"; tput sgr0)
WARN=$(tput setaf 3; echo -n "[WARN] [$(date)]"; tput sgr0)
ERROR=$(tput setaf 1; echo -n "[ERROR] [$(date)]"; tput sgr0)

# Define colors
NOTE_INFO=$(tput setaf 6)

#!/bin/bash
script_dir=$(dirname "$(readlink -f "$0")")

res=$(which 7z)
if [ $? != 0 ]; then
    echo "${INFO} Please install 7z on your system!"
    exit
fi

echo "${INFO} 7z is installed in your system!"

pip3 install dfss -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade
python3 -m dfss --url=open@sophgo.com:/sophon-demo/Llama2/models.7z
python3 -m dfss --url=open@sophgo.com:/sophon-demo/Llama2/tools.7z

if [ ! -d "./models" ]; then
    mkdir -p ./models
fi

if [ ! -d "./models/BM1684X" ]; then
    mkdir -p ./models/BM1684X
fi

7z x models.7z -o./models/BM1684X
if [ "$?" = "0" ]; then
  rm models.7z
  echo "${INFO} Models are ready"
else
  echo "${INFO} Models unzip error"
fi

7z x tools.7z -o.
if [ "$?" = "0" ]; then
  rm tools.7z
  echo "${INFO} Tools are ready"
else
  echo "${INFO} Tools unzip error"
fi

if [ ! -d "./python/token_config" ];
then
pushd ./python > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Llama2/token_config.7z
    7z x token_config.7z -o.
    rm token_config.7z
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
else
    echo "${INFO} token_config exists! Remove it if you need to update."
fi