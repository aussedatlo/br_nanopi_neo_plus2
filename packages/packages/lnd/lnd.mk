################################################################################
#
# lnd
#
################################################################################

LND_VERSION = v0.10.1-beta.rc2
LND_SITE = https://github.com/lightningnetwork/lnd/archive
LND_SOURCE = $(LND_VERSION).tar.gz

LND_VENDOR_SOURCE = \
https://github.com/lightningnetwork/lnd/releases/download/$(LND_VERSION)/vendor.tar.gz

# LND_WORKSPACE = vendor

# define LND_PRE_BUILD
# 	wget $(LND_VENDOR_SOURCE) -O $(@D)/vendor.tar.gz
# 	tar -xf $(@D)/vendor.tar.gz -C $(@D)
# endef

define LND_BUILD_CMDS
	$(MAKE) build GO=$(HOST_DIR)/bin/go $(GO_TARGET_ENV) -C $(@D)
endef

define LND_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/lnd-debug $(TARGET_DIR)/usr/bin/lnd
	$(INSTALL) -m 755 $(@D)/lncli-debug $(TARGET_DIR)/usr/bin/lncli
endef

LND_PRE_BUILD_HOOKS += LND_PRE_BUILD

$(eval $(golang-package))