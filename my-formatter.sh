#!/bin/bash

# 获取传入的文件名并提取后缀
FILENAME=$1
EXT="${FILENAME##*.}"

# 如果没有传入文件名，或者无法识别后缀，默认从标准输入读取并输出
case "$EXT" in
    c|cpp|h|hpp|cc|cxx)
        # 使用 clang-format，-style=file 会寻找项目中的 .clang-format 配置
        clang-format --assume-filename="$FILENAME"
        ;;
    java)
        # google-java-format 默认只输出到 stdout，适合管道
        google-java-format -
        ;;
    toml)
        # taplo 是目前 Helix 社区最推荐的 TOML 格式化/LSP 工具
        taplo format -
        ;;
    lua)
        # stylua 是 Lua 的主流格式化工具
        stylua -
        ;;
    py)
        # python 使用 black 或 ruff
        black -q -
        ;;
    rs)
        # rust 使用 rustfmt
        rustfmt --edition 2021
        ;;
    js|ts|jsx|tsx|json|html|css)
        # 前端全家桶通常交给 prettier
        prettier --stdin-filepath "$FILENAME"
        ;;
    *)
        # 如果匹配不到，则原样输出，防止清空缓冲区
        cat
        ;;
esac
