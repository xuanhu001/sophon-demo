#!/bin/bash
# 定义颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# 定义所有工程目录
projects=(
    # "Baichuan2"
    # "BERT"
    # "ByteTrack"
    # "C3D"
    # "CenterNet"
    # "ChatGLM2"
    # "ChatGLM3"
    # "ChatGLM4"
    # "CLIP"
    # "DeepSORT"
    # "GroundingDINO"
    # "Llama2"
    # "LPRNet"
    # "MiniCPM"
    # "OpenPose"
    # "P2PNet"
    # "PP-OCR"
    "ppYoloe"
    "ppYOLOv3"
    # "Qwen"
    # "Qwen-VL-Chat"
    # "Qwen1_5"
    "Real-ESRGAN"
    # "ResNet"
    "RetinaFace"
    # "SAM"
    # "SCRFD"
    # "Seamless"
    # "segformer"
    "SSD"
    # "StableDiffusionV1_5"
    # "StableDiffusionXL"
    "SuperGlue"
    "WeNet"
    # "Whisper"
    "yolact"
    "YOLOv10"
    "YOLOv34"
    "YOLOv5"
    "YOLOv5_fuse"
    "YOLOv5_opt"
    "YOLOv7"
    "YOLOv8_det"
    "YOLOv8_seg"
    "YOLOv9_det"
    "YOLOv9_seg"
    "YOLOX"
)

# 定义颜色
# RED=$(tput setaf 1)
# GREEN=$(tput setaf 2)
# YELLOW=$(tput setaf 3)
# RESET=$(tput sgr0)

# 输出当前时间和命令
echo -e "${GREEN}[INFO]${YELLOW}开始执行下载脚本：${NC}$(date "+%F %T")"
echo -e "${GREEN}[INFO]${YELLOW}当前目录：${NC}$(pwd)"
echo -e "${GREEN}[INFO]${YELLOW}将要执行的命令：${NC}"

count=0
for project in ${projects[@]}; do
    ((count++))
    # echo -e "${YELLOW}$count${NC}"
    if [ -d "${project}" ]; then
        pushd ${project} >/dev/null
        if [ -f "./scripts/download.sh" ] && [ -x "./scripts/download.sh" ]; then
            echo -e "${GREEN}[INFO]${YELLOW}[序号$count]当前目录是：${NC}$(pwd)"
            ./scripts/download.sh
            echo -e "${GREEN}[INFO]${YELLOW}${project}执行完成，当前时间${NC}$(date "+%F %T")"
        else
            echo -e "${RED}[ERROR]${YELLOW}在目录${project}中找不到可执行的download.sh脚本${NC}"
        fi
        popd >/dev/null
    else
        echo -e "${RED}[ERROR]${YELLOW}找不到目录${project}${NC}"
    fi
done

echo -e "${GREEN}[INFO]${YELLOW}执行结束时间：${NC}$(date "+%F %T")"
echo "-------------------------------------------------"
echo -e "${GREEN}[INFO]${YELLOW}所有项目下载完成！${NC}"

# nohup ./run_download.sh > download.log 2>&1 &
