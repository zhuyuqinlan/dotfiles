#!/bin/bash
# 设置中文环境
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
export LANGUAGE=zh_CN:zh

# 设置输入法
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# 设置默认编辑器
export EDITOR=vim
export VISUAL=gnome-text-editor

# 解决Java GUI程序运行问题
export _JAVA_AWT_WM_NONREPARENTING=1
export STUDIO_JDK=/usr/lib/jvm/java-11-openjdk/

sway
