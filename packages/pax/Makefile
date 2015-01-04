include $(TOPDIR)/rules.mk

# http://slackbuilds.org/repository/14.1/system/paxctl/
# http://wiki.gentoo.org/wiki/Hardened/PaX_Quickstart

PKG_NAME:=paxctl
PKG_VERSION:=0.9
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pax.grsecurity.net/
PKG_MD5SUM:=9bea59b1987dc4e16c2d22d745374e64

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_VERSION)

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

PKG_MAINTAINER:=Andrew McDonnell <bugs@andrewmcdonnell.net>

include $(INCLUDE_DIR)/package.mk

define Package/paxctl
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=paxctl
endef

define Package/paxctl/description
 paxctl
endef

define Build/Configure
endef

PAX_CFLAGS:=-Os -ggdb -Wall -W -Wcast-qual -Wcast-align -Wbad-function-cast -Wshadow -Wwrite-strings -Wnested-externs -Winline -Wredundant-decls -Waggregate-return -Wformat=2 -Wpointer-arith -Wconversion -Wmissing-declarations -Wmissing-prototypes

# Not working, makefile is stupid	$(MAKE) -C $(PKG_BUILD_DIR) CC:=$(CC) paxctl
define Build/Compile
	cd $(PKG_BUILD_DIR) && $(TARGET_CC) $(PAX_CFLAGS) $(TARGET_CFLAGS) -c paxctl.c -o paxctl.o
	cd $(PKG_BUILD_DIR) && $(TARGET_CC) paxctl.o $(TARGET_LDFLAGS) -o paxctl
endef

define Build/Install
endef

define Package/paxctl/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/paxctl $(1)/usr/sbin
endef

$(eval $(call BuildPackage,paxctl))
