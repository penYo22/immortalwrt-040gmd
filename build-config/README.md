# ImmortalWrt GitHub Actions Build Config

This directory controls the GitHub Actions firmware build.

The workflow checks out this repository as a config repository, then clones
the source with:

```bash
git clone --depth=1 --single-branch --branch=6.18 https://github.com/bingoguo93/immortalwrt.git immortalwrt-25.12
```

- `seed.config`: target platform and base firmware options.
- `packages.config`: LuCI apps and other packages you want to add or remove.
- `diy.sh`: optional commands that run before `.config` is generated.

The default target is `airoha/an7581`.

To add a plugin, append a line such as:

```text
CONFIG_PACKAGE_luci-app-ttyd=y
```

To remove a package, append a line such as:

```text
# CONFIG_PACKAGE_luci-app-opkg is not set
```

After editing, open **Actions -> Build ImmortalWrt -> Run workflow**.

When `upload_release` is enabled, the workflow creates a Release named by
build time, includes target/platform/login/plugin information in the Release
body, and uploads firmware files plus build metadata.
