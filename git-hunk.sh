#!/bin/bash

# 检查输入参数
if [ "$#" -ne 2 ]; then
    echo "错误: 参数不足！"
    echo "用法: $0 <文件名> <行号>"
    exit 1
fi

FILE_NAME=$1
LINE_NUM=$2

# 检查文件是否存在
if [ ! -f "$FILE_NAME" ]; then
    echo "错误: 文件 '$FILE_NAME' 不存在！"
    exit 1
fi

# 检查目标文件是否在 Git 仓库中
if ! git ls-files --error-unmatch "$FILE_NAME" > /dev/null 2>&1; then
    echo "错误: 文件 '$FILE_NAME' 未被 Git 追踪。"
    exit 1
fi

# -U0 确保 Git 不输出任何未变动的上下文
DIFF_OUTPUT=$(git diff -U0 HEAD -- "$FILE_NAME")

if [ -z "$DIFF_OUTPUT" ]; then
    echo "提示: 文件 '$FILE_NAME' 当前没有未提交的本地修改。"
    exit 0
fi

# 解析 diff 输出
echo "$DIFF_OUTPUT" | awk -v ln="$LINE_NUM" '
    # 匹配 hunk 头部，例如 @@ -1,4 +1,4 @@
    /^@@/ {
        n = split($3, a, ",");
        
        # 【彻底修复】严格带上数组下标 [1] 和 [2]，彻底根除 awk 数组报错
        start = substr(a[1], 2) + 0; 
        len = (n < 2) ? 1 : a[2] + 0; 
        end = start + len - 1;
        
        # 兼容纯删除的边缘情况
        if (len == 0) { end = start }

        # 判断输入的行号是否落在这个 hunk 范围内
        if (ln >= start && ln <= end) {
            inside_hunk = 1;
            next;
        } else {
            inside_hunk = 0;
        }
    }
    
    # 如果处于目标 hunk 内
    inside_hunk {
        if (/^diff / || /^--- / || /^\+\+\+ /) {
            inside_hunk = 0;
            next;
        }
        if (/^[+-]/) {
            print $0;
        }        
    }
'
