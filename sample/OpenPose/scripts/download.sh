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
    mkdir -p ../datasets/coco
    # test.zip
    python3 -m dfss --url=open@sophgo.com:sophon-demo/common/test.zip
    unzip test.zip -d ../datasets/
    rm test.zip

    # coco128.zip
    python3 -m dfss --url=open@sophgo.com:sophon-demo/common/coco128.zip
    unzip coco128.zip -d ../datasets/
    rm coco128.zip

    # dance_1080P.mp4
    python3 -m dfss --url=open@sophgo.com:sophon-demo/common/dance_1080P.mp4
    mv dance_1080P.mp4 ../datasets/

    # val2017_1000.zip
    python3 -m dfss --url=open@sophgo.com:sophon-demo/common/val2017_1000.zip
    unzip val2017_1000.zip -d ../datasets/coco
    rm val2017_1000.zip

    # person_keypoints_val2017_1000.json
    python3 -m dfss --url=open@sophgo.com:sophon-demo/OpenPose/datasets_0918/person_keypoints_val2017_1000.json
    mv person_keypoints_val2017_1000.json ../datasets/coco

    echo "${INFO} datasets download!"
else
    echo "${INFO} datasets exist!"
fi

# models
if [ ! -d "../models" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/OpenPose/models_0918/models.zip
    unzip models.zip -d ../
    rm models.zip

    python3 -m dfss --url=open@sophgo.com:sophon-demo/OpenPose/BM1688.zip
    unzip BM1688.zip -d ../models
    rm BM1688.zip
    echo "${INFO} models download!"
else
    echo "${INFO} models exist!"
fi
popd > /dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"