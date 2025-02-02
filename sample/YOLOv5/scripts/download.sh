# Define log levels with date
INFO=$(
    tput setaf 2
    echo -n "[INFO] [$(date)]"
    tput sgr0
)
WARN=$(
    tput setaf 3
    echo -n "[WARN] [$(date)]"
    tput sgr0
)
ERROR=$(
    tput setaf 1
    echo -n "[ERROR] [$(date)]"
    tput sgr0
)

# Define colors
NOTE_INFO=$(tput setaf 6)

#!/bin/bash
pip3 install dfss -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade
scripts_dir=$(dirname $(readlink -f "$0"))

pushd $scripts_dir >/dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
# datasets
if [ ! -d "../datasets" ]; then
    mkdir ../datasets
    pushd ../datasets >/dev/null
    echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/common/test.tar.gz    #test pictures
    tar xvf test.tar.gz && rm test.tar.gz                                   #in case `tar xvf xx` failed.
    python3 -m dfss --url=open@sophgo.com:sophon-demo/common/coco.names     #coco classnames
    python3 -m dfss --url=open@sophgo.com:sophon-demo/common/coco128.tar.gz #coco 128 pictures
    tar xvf coco128.tar.gz && rm coco128.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/common/coco_val2017_1000.tar.gz #coco 1000 pictures and json.
    tar xvf coco_val2017_1000.tar.gz && rm coco_val2017_1000.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/common/test_car_person_1080P.mp4 #test video
    popd >/dev/null
    echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    echo "${INFO} datasets download!"
else
    echo "${INFO} Datasets folder exist! Remove it if you need to update."
fi

# models
if [ ! -d "../models" ]; then
    mkdir ../models
    pushd ../models >/dev/null
    echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv5/models/BM1684.tar.gz
    tar xvf BM1684.tar.gz && rm BM1684.tar.gz
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv5/models/BM1684_ext.tar.gz
    # tar xvf BM1684_ext.tar.gz && rm BM1684_ext.tar.gz
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv5/models/BM1684X.tar.gz
    # tar xvf BM1684X.tar.gz && rm BM1684X.tar.gz
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv5/models/BM1684X_ext.tar.gz
    # tar xvf BM1684X_ext.tar.gz && rm BM1684X_ext.tar.gz
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv5/models/BM1688.tar.gz
    # tar xvf BM1688.tar.gz && rm BM1688.tar.gz
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv5/models/CV186X.tar.gz
    # tar xvf CV186X.tar.gz && rm CV186X.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv5/models/onnx.tar.gz
    tar xvf onnx.tar.gz && rm onnx.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv5/models/torch.tar.gz
    tar xvf torch.tar.gz && rm torch.tar.gz
    popd >/dev/null
    echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    echo "${INFO} models download!"
else
    echo "${INFO} Models folder exist! Remove it if you need to update."
fi
popd >/dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
