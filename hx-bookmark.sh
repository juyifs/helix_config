#!/bin/bash
# 路径: ~/.config/helix/hx-bookmark.sh

BOOKMARK_FILE="./.helix_bookmarks"

case "$1" in
    add)
        # 从管道读取备注内容
        remark=$(cat)
        # 如果没有选中内容，备注默认为 "No remark"
        [ -z "$remark" ] && remark="No remark"
        # 参数: 文件路径 行号 备注
        echo "# $remark" >> "$BOOKMARK_FILE"
        echo "$2:$3" >> "$BOOKMARK_FILE"
        ;;
    list)
        # 格式化输出供选择，如果文件不存在则退出
        [ -f "$BOOKMARK_FILE" ] && cat -n "$BOOKMARK_FILE"
        ;;
esac

