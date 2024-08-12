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
res=$(which unzip)
if [ $? != 0 ]; then
    echo "${INFO} Please install unzip on your system!"
    exit
fi
pip3 install dfss -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade
scripts_dir=$(dirname $(readlink -f "$0"))

pushd $scripts_dir >/dev/null
echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
# datasets
if [ ! -d "../datasets" ]; then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv5/datasets_0918/datasets.zip
    unzip datasets.zip -d ../
    rm datasets.zip

    echo "${INFO} datasets download!"
else
    echo "${INFO} Datasets folder exist! Remove it if you need to update."
fi

if [ ! -d "../models" ]; then
    mkdir ../models
    pushd ../models >/dev/null
    echo "${INFO} Changed directory to ${NOTE_INFO}$(pwd)"
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv8_seg/models/BM1684.tar.gz
    tar xvf BM1684.tar.gz
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv8_seg/models/BM1684X.tar.gz
    # tar xvf BM1684X.tar.gz
    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv8_seg/models/BM1688.tar.gz
    # tar xvf BM1688.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv8_seg/models/onnx.tar.gz
    tar xvf onnx.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv8_seg/models/torch.tar.gz
    tar xvf torch.tar.gz
    rm *.tar.gz
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv8_seg/models/BM1684X/yolov8s_getmask_32_fp32.bmodel
    mv yolov8s_getmask_32_fp32.bmodel BM1684X/
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv8_seg/models/onnx/yolov8s_getmask_32_fp32.onnx
    mv yolov8s_getmask_32_fp32.onnx onnx/

    popd >/dev/null
    echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
    echo "${INFO} models download!"
else
    echo "${INFO} Models folder exist! Remove it if you need to update."
fi
popd >/dev/null
echo "${INFO} Changed directory back to ${NOTE_INFO}$(pwd)"
