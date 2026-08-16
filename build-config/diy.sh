#!/usr/bin/env bash
set -euo pipefail

mkdir -p package/custom

# an7581 target 只声明了 FEATURES+=pwm,缺少 fpu(cortex-a53 实际有硬件FPU)。
# HAS_FPU 为假会导致 node 及依赖 node 的包(UnblockNeteaseMusic 等)被 kconfig 静默隐藏。
sed -i 's/^FEATURES+=pwm$/FEATURES+=pwm fpu/' target/linux/airoha/an7581/target.mk

git clone --depth=1 https://github.com/rchen14b/luci-app-airoha-npu.git \
  package/custom/luci-app-airoha-npu
# 该仓库 Makefile 用相对路径 include ../../luci.mk,只在 luci feed 目录内有效;
# 克隆到 package/custom/ 下需改为绝对路径,否则包无法被构建系统识别
sed -i 's|include ../../luci.mk|include $(TOPDIR)/feeds/luci/luci.mk|' \
  package/custom/luci-app-airoha-npu/Makefile

# gecoosac:kenzok8/small-package 已移除核心包,改用 lyin888/openwrt-gecoosac(核心+界面齐全)
git clone --depth=1 https://github.com/lyin888/openwrt-gecoosac.git /tmp/openwrt-gecoosac
cp -a /tmp/openwrt-gecoosac/gecoosac package/custom/
cp -a /tmp/openwrt-gecoosac/luci-app-gecoosac package/custom/

# unblockneteasemusic:luci feed 版被 defconfig 丢弃,改用 kenzok8 自包含版(界面+Node 版核心)
git clone --depth=1 --filter=blob:none --sparse https://github.com/kenzok8/small-package.git \
  /tmp/small-package
(
  cd /tmp/small-package
  git sparse-checkout set luci-app-unblockneteasemusic UnblockNeteaseMusic
)
cp -a /tmp/small-package/luci-app-unblockneteasemusic package/custom/
cp -a /tmp/small-package/UnblockNeteaseMusic package/custom/

if [ -d build-config/files ]; then
  cp -a build-config/files/. files/
fi
