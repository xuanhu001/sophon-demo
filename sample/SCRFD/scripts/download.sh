# Define log levels with date
INFO=$(tput setaf 2; echo -n "[INFO] [$(date)]"; tput sgr0)
WARN=$(tput setaf 3; echo -n "[WARN] [$(date)]"; tput sgr0)
ERROR=$(tput setaf 1; echo -n "[ERROR] [$(date)]"; tput sgr0)

# Define colors
NOTE_INFO=$(tput setaf 6)

#!/bin/bash
pip3 install dfss

res=$(which unzip)
if [ $? != 0 ];
then
    echo "${INFO} Please install unzip on your system!"
    echo "${INFO} To install, use the following command:"
    echo "${INFO} sudo apt install unzip"
    exit
fi

scripts_dir=$(dirname $(readlink -f "$0"))
# echo $scripts_dir

pushd $scripts_dir > /dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"

# datasets
if [ ! -d "../datasets" ];
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/SCRFD/datasets.zip
    unzip datasets.zip -d ../
    rm datasets.zip

    echo "${INFO} datasets download!"
else
    echo "${INFO} datasets exist!"
fi

# models
if [ ! -d "../models" ];
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/SCRFD/models.zip
    unzip models.zip -d ../
    rm models.zip
    echo "${INFO} models download!"
else
    echo "${INFO} models exist!"
fi

# ground_truth
if [ ! -d "../tools/ground_truth" ];
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/SCRFD/ground_truth.zip
    unzip ground_truth.zip -d ../tools/
    rm ground_truth.zip
    echo "${INFO} ground_truth download!"
else
    echo "${INFO} ground_truth exist!"
fi
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
