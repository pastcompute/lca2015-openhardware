include $(TOPDIR)/rules.mk

# http://wiki.gentoo.org/wiki/Hardened/PaX_Quickstart

# make package/feeds/customfeed/hello/clean

PKG_NAME:=hello
PKG_VERSION:=0.0.1
PKG_RELEASE:=1

PKG_LICENSE:=GPLv2 LGPLv2.1
PKG_LICENSE_FILES:=

PKG_MAINTAINER:=Andrew McDonnell <bugs@andrewmcdonnell.net>

include $(INCLUDE_DIR)/package.mk

define Package/hello
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Hello
	DEPENDS:= +SSP_SUPPORT:libssp
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) src/* $(PKG_BUILD_DIR)/
endef

define Build/Configure
endef

TARGET_CFLAGS += $(FPIC)

ifneq ($(CONFIG_SSP_SUPPORT),y)
else
TARGET_CFLAGS += -fstack-protector-all
endif


define Build/Compile
	@echo compile
	$(MAKE) -C $(PKG_BUILD_DIR) $(TARGET_CONFIGURE_OPTS) CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" all
endef

define Package/hello/install
	$(INSTALL_DIR) $(1)/usr/local/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mmap-rw $(1)/usr/local/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/mmap-rwx $(1)/usr/local/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/aslr-test-withpie $(1)/usr/local/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/aslr-test-without $(1)/usr/local/bin
endef
$(eval $(call BuildPackage,hello))
