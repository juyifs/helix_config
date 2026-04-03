#!/bin/bash
# 路径: ~/.config/helix/save_session.sh.sh
mkdir -p ./.helix

BOOKMARK_FILE="./.helix/.session"

# 检查文件是否存在，如果不存在则创建（防止 grep 报错）
touch "$BOOKMARK_FILE"

# 使用 grep 检查文件中是否已存在 $1
# -q 表示静默模式，不输出内容
if grep -q "$1" "$BOOKMARK_FILE"; then
    exit 0
else
    echo "$1:$2" >> "$BOOKMARK_FILE"
    sync
fi
