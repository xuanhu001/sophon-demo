#!/bin/bash
# 注意会将文件传输至目标文件的子目录下！
set -e

# 测试
# echo "scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/P2PNet linaro@$IP:/mnt/sophonWP/sophon-demo/sample/P2PNet"
scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/P2PNet linaro@$IP:/mnt/sophonWP/sophon-demo/sample/P2PNet || exit 1

scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/PP-OCR linaro@IP:/mnt/sophonWP/sophon-demo/sample/PP-OCR || exit 1
scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/Real-ESRGAN linaro@IP:/mnt/sophonWP/sophon-demo/sample/Real-ESRGAN || exit 1
scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/SCRFD linaro@IP:/mnt/sophonWP/sophon-demo/sample/SCRFD || exit 1
# scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/StableDiffusionXL linaro@IP:/mnt/sophonWP/sophon-demo/sample/StableDiffusionXL || exit 1
scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/YOLOX linaro@IP:/mnt/sophonWP/sophon-demo/sample/YOLOX || exit 1
scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/YOLOv34 linaro@IP:/mnt/sophonWP/sophon-demo/sample/YOLOv34 || exit 1
scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/YOLOv5_opt linaro@IP:/mnt/sophonWP/sophon-demo/sample/YOLOv5_opt || exit 1
scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/YOLOv8_det linaro@IP:/mnt/sophonWP/sophon-demo/sample/YOLOv8_det || exit 1
scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/YOLOv9_det linaro@IP:/mnt/sophonWP/sophon-demo/sample/YOLOv9_det || exit 1
scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/YOLOv9_seg linaro@IP:/mnt/sophonWP/sophon-demo/sample/YOLOv9_seg || exit 1
# scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/ppYOLOv3 linaro@IP:/mnt/sophonWP/sophon-demo/sample/ppYOLOv3 || exit 1
scp -r /home/data/wcy/DEBUG/DLWP/sophon-demo/sample/segformer linaro@IP:/mnt/sophonWP/sophon-demo/sample/segformer || exit 1

# mkdir /mnt/sophonWP/sophon-demo/sample/tmp
# mv /mnt/sophonWP/sophon-demo/sample/P2PNet/P2PNet /mnt/sophonWP/sophon-demo/sample/tmp/
# mv /mnt/sophonWP/sophon-demo/sample/PP-OCR/PP-OCR /mnt/sophonWP/sophon-demo/sample/tmp/
# mv /mnt/sophonWP/sophon-demo/sample/Real-ESRGAN/Real-ESRGAN /mnt/sophonWP/sophon-demo/sample/tmp/
# mv /mnt/sophonWP/sophon-demo/sample/SCRFD/SCRFD /mnt/sophonWP/sophon-demo/sample/tmp/
# mv /mnt/sophonWP/sophon-demo/sample/YOLOX/YOLOX /mnt/sophonWP/sophon-demo/sample/tmp/
# mv /mnt/sophonWP/sophon-demo/sample/YOLOv34/YOLOv34 /mnt/sophonWP/sophon-demo/sample/tmp/
# mv /mnt/sophonWP/sophon-demo/sample/YOLOv5_opt/YOLOv5_opt /mnt/sophonWP/sophon-demo/sample/tmp/
# mv /mnt/sophonWP/sophon-demo/sample/YOLOv8_det/YOLOv8_det /mnt/sophonWP/sophon-demo/sample/tmp/
# mv /mnt/sophonWP/sophon-demo/sample/YOLOv9_det/YOLOv9_det /mnt/sophonWP/sophon-demo/sample/tmp/
# mv /mnt/sophonWP/sophon-demo/sample/YOLOv9_seg/YOLOv9_seg /mnt/sophonWP/sophon-demo/sample/tmp/
# mv /mnt/sophonWP/sophon-demo/sample/segformer/segformer /mnt/sophonWP/sophon-demo/sample/tmp/
# rm -rf /mnt/sophonWP/sophon-demo/sample/P2PNet
# rm -rf /mnt/sophonWP/sophon-demo/sample/PP-OCR
# rm -rf /mnt/sophonWP/sophon-demo/sample/Real-ESRGAN
# rm -rf /mnt/sophonWP/sophon-demo/sample/SCRFD
# rm -rf /mnt/sophonWP/sophon-demo/sample/YOLOX
# rm -rf /mnt/sophonWP/sophon-demo/sample/YOLOv34
# rm -rf /mnt/sophonWP/sophon-demo/sample/YOLOv5_opt
# rm -rf /mnt/sophonWP/sophon-demo/sample/YOLOv8_det
# rm -rf /mnt/sophonWP/sophon-demo/sample/YOLOv9_det
# rm -rf /mnt/sophonWP/sophon-demo/sample/YOLOv9_seg
# rm -rf /mnt/sophonWP/sophon-demo/sample/segformer
# mv /mnt/sophonWP/sophon-demo/sample/tmp/P2PNet /mnt/sophonWP/sophon-demo/sample/
# mv /mnt/sophonWP/sophon-demo/sample/tmp/PP-OCR /mnt/sophonWP/sophon-demo/sample/
# mv /mnt/sophonWP/sophon-demo/sample/tmp/Real-ESRGAN /mnt/sophonWP/sophon-demo/sample/
# mv /mnt/sophonWP/sophon-demo/sample/tmp/SCRFD /mnt/sophonWP/sophon-demo/sample/
# mv /mnt/sophonWP/sophon-demo/sample/tmp/YOLOX /mnt/sophonWP/sophon-demo/sample/
# mv /mnt/sophonWP/sophon-demo/sample/tmp/YOLOv34 /mnt/sophonWP/sophon-demo/sample/
# mv /mnt/sophonWP/sophon-demo/sample/tmp/YOLOv5_opt /mnt/sophonWP/sophon-demo/sample/
# mv /mnt/sophonWP/sophon-demo/sample/tmp/YOLOv8_det /mnt/sophonWP/sophon-demo/sample/
# mv /mnt/sophonWP/sophon-demo/sample/tmp/YOLOv9_det /mnt/sophonWP/sophon-demo/sample/
# mv /mnt/sophonWP/sophon-demo/sample/tmp/YOLOv9_seg /mnt/sophonWP/sophon-demo/sample/
# mv /mnt/sophonWP/sophon-demo/sample/tmp/segformer /mnt/sophonWP/sophon-demo/sample/
# rm -rf /mnt/sophonWP/sophon-demo/sample/tmp


