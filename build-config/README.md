# ImmortalWrt GitHub Actions Build Config

This directory controls the GitHub Actions firmware build.

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

