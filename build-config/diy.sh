#!/usr/bin/env bash
set -euo pipefail

mkdir -p package/custom

git clone --depth=1 https://github.com/rchen14b/luci-app-airoha-npu.git \
  package/custom/luci-app-airoha-npu
# 该仓库 Makefile 用相对路径 include ../../luci.mk,只在 luci feed 目录内有效;
# 克隆到 package/custom/ 下需改为绝对路径,否则包无法被构建系统识别
sed -i 's|include ../../luci.mk|include $(TOPDIR)/feeds/luci/luci.mk|' \
  package/custom/luci-app-airoha-npu/Makefile

git clone --depth=1 --filter=blob:none --sparse https://github.com/kenzok8/small-package.git \
  /tmp/small-package
(
  cd /tmp/small-package
  git sparse-checkout set luci-app-gecoosac gecoosac || git sparse-checkout set luci-app-gecoosac
)
cp -a /tmp/small-package/luci-app-gecoosac package/custom/
if [ -d /tmp/small-package/gecoosac ]; then
  cp -a /tmp/small-package/gecoosac package/custom/
fi

if [ -d build-config/files ]; then
  cp -a build-config/files/. files/
fi
