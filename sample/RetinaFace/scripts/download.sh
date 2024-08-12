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
if [ ! -d "../data" ]; 
then
    mkdir -p ../data/
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Retinaface/data_0918/images.zip
    unzip images.zip -d ../data/
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Retinaface/data_0918/videos.zip
    unzip videos.zip -d ../data/
    python3 -m dfss --url=open@sophgo.com:sophon-demo/Retinaface/data_0918/models.zip
    unzip models.zip -d ../data/
    rm images.zip videos.zip models.zip
else
    echo "${INFO} Data folder exist! Remove it if you need to update."
fi

popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"


