#!/bin/bash

FILE_PATH="$1"
EXTENSION="${FILE_PATH##*.}"

ROOT_DIR=$(pwd)
TARGET_DIR="$ROOT_DIR/.helix/preview"

# 确保在当前运行目录下创建文件夹
mkdir -p "$TARGET_DIR"

case "$EXTENSION" in
    "md")
        pandoc -s -c ~/.config/helix/style.css --self-contained "$FILE_PATH" -o "$TARGET_DIR/output.html"
        ;;
    "pu" | "puml")
        plantuml -tsvg "$FILE_PATH" -o "$TARGET_DIR"
        ;;
    *)
        echo "未定义的运行命令: $EXTENSION"
        ;;
esac
