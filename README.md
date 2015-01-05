lca2015-openhardware
====================

Scripts used to build demo firmware for LCA2015 open hardware presentation.


Building the Firmware for the Demos
-----------------------------------

**Note, the following operation will check if `openwrt/` exists and clone it from the following if not: `https://github.com/pastcompute/openwrt-cc-ar71xx-hardened.git`.**

**Note, the first time this is run it will incur a large number of downloads for all the OpenWRT toolchain and userspace constituent source packages.**


```
git clone https://github.com/pastcompute/lca2015-openhardware.git
cd lca2015-openhardware
./build.sh
```

This results in the following files:

* `demoA` -- firmware of plain old OpenWRT
* `demoB` -- firmware of OpenWRT with grsecurity patches applied but not yet enabled
* `demoC` -- firmware of OpenWRT with grsecurity patches applied and enabled

The script will also try and copy the files into `/srv/tftp` if it exists.

Preparing for downloads
-----------------------

On Debian Wheezy I did the following:

* Installed tftpd-hpa
* Enabled tftp services on `/srv/tftp`

Downloading each firmware into a Carambola2
-------------------------------------------

1. Connect USB port
2. Run minicom or another terminal
        minicom -D /dev/ttyUSB0 -b 115200
3. Reset the Carambola2
4. Enter U-boot by pressing `ESC`
5. Upload the firmware:
        tftpboot 80500000 demoA
        bootm 0x80500000



