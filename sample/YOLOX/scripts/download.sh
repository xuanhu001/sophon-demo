#!/bin/bash
pip3 install dfss
# sudo apt install unzip

scripts_dir=$(dirname $(readlink -f "$0"))
# echo $scripts_dir

pushd $scripts_dir
# datasets
if [ ! -d "../datasets" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOv5/datasets_0918/datasets.zip
    unzip datasets.zip -d ../
    rm datasets.zip

    echo "datasets download!"
else
    echo "datasets exist!"
fi

# models
if [ ! -d "../models" ]; 
then
    python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOX/models_1220/models.zip
    unzip models.zip -d ../
    rm models.zip

    # python3 -m dfss --url=open@sophgo.com:sophon-demo/YOLOX/models_20240422/CV186X_models.tar.gz
    # tar -zxvf CV186X_models.tar.gz -C ../
    # rm CV186X_models.tar.gz

    echo "models download!"
else
    echo "models exist!"
fi
popd

