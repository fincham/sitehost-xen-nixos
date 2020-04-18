# sitehost-xen-nixos

A basic NixOS `configuration.nix` suitable for use with SiteHost's Xen based VPS platform (https://sitehost.nz/). Can be installed on to a Debian VPS either with "lustrate" or from "Rescue Mode". This is totally unsupported by SiteHost but it seems to work :)

For the "Console" to work both `xen_fbfront` and `xen_kbdfront` kernel modules will also need to be loaded, though having `kbdfront` loaded causes me some small issues while rebuilding, so I've omitted it from the initrd list here.

Because SiteHost uses `pv-grub` as a bootloader it's not as easy to change generation at boot time as it would be on a standalone system. It is however fairly easy to boot in to "Rescue Mode" and edit `/boot/grub/menu.lst` to ensure the desired generation will be booted.

## Future improvements

It would be nice if this could import and override defaults from `nixpkgs/nixos/modules/virtualisation/xen-domU.nix` but it's a starting point at least.
