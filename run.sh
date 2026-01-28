#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "错误：参数数量不正确。"
  echo "用法: $0 <子目录名称> <执行动作>"
  echo "执行动作: run, clean"
  exit 1
fi

SUBDIR=$1
ACTION=$2

if [ ! -d "$SUBDIR" ]; then
  echo "错误：子目录 '$SUBDIR' 不存在。"
  exit 1
fi

case "$ACTION" in
"run")
  echo "--- [开始] 执行 'run' 动作 ---"
  echo "进入子目录 '$SUBDIR' 执行 'make'..."
  if (cd "$SUBDIR" && make); then
    echo "make 执行成功。"
    echo "已返回父目录。"
    echo "正在运行 'bochs -f bochsrc .'..."
    bochs -f bochsrc
  else
    echo "错误：'make' 在子目录 '$SUBDIR' 中执行失败。"
    exit 1
  fi
  echo "--- [完成] 'run' 动作 ---"
  ;;

"clean")
  echo "--- [开始] 执行 'clean' 动作 ---"
  echo "进入子目录 '$SUBDIR' 执行 'make clean'..."
  if (cd "$SUBDIR" && make clean); then
    echo "make clean 执行成功。"
  else
    echo "错误：'make clean' 在子目录 '$SUBDIR' 中执行失败。"
    exit 1
  fi
  echo "已返回父目录。"
  echo "--- [完成] 'clean' 动作 ---"
  ;;

*)
  echo "错误：未知的执行动作 '$ACTION'。"
  echo "请使用 'run' 或 'clean' 作为第二个参数。"
  exit 1
  ;;
esac

exit 0
