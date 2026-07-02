# ImmortalWrt GitHub Actions Build Config

This directory controls the GitHub Actions firmware build.

The workflow checks out this repository as a config repository, then clones
the source with:

```bash
git clone --depth=1 --single-branch --branch=6.18 https://github.com/bingoguo93/immortalwrt.git immortalwrt-25.12
```

Files:

- `seed.config`: target platform and base firmware options.
- `packages.config`: LuCI apps and other packages to add or remove.
- `diy.sh`: optional commands that run before `.config` is generated.
  It currently fetches third-party packages such as `luci-app-airoha-npu`
  and `luci-app-gecoosac`.

The default target is `airoha/an7581` with device profile
`bell_xg-040g-md`.

Release assets are limited to two `.bin` firmware files:

```text
immortalwrt-airoha-an7581-bell_xg-040g-md-squashfs-factory.bin
immortalwrt-airoha-an7581-bell_xg-040g-md-squashfs-sysupgrade.bin
```

To add a plugin, append a line such as:

```text
CONFIG_PACKAGE_luci-app-ttyd=y
```

To remove a package, append a line such as:

```text
# CONFIG_PACKAGE_luci-app-opkg is not set
```

After editing, open **Actions -> Build ImmortalWrt -> Run workflow**.
