#!/bin/bash

# 切换到脚本所在的目录（防止双击运行时默认定位到家目录）
cd "$(dirname "$0")"

# 获取当前文件夹的名字
FOLDER_NAME=$(basename "$PWD")

# 生成结构图并保存为 .txt
# 这里使用 find 命令模拟树状结构，无需额外安装工具
echo "Directory structure for: $FOLDER_NAME" > "${FOLDER_NAME}.txt"
echo "==================================" >> "${FOLDER_NAME}.txt"
find . -not -path '*/.*' | sed -e "s/[^-][^\/]*\// |/g" -e "s/|\([^ ]\)/|-- \1/" >> "${FOLDER_NAME}.txt"

echo "生成成功！文件名是：${FOLDER_NAME}.txt"
