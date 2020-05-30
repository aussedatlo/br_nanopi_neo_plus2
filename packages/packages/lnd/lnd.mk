################################################################################
#
# lnd
#
################################################################################

LND_VERSION = v0.10.1-beta.rc2
LND_SITE = https://github.com/lightningnetwork/lnd/archive
LND_SOURCE = $(LND_VERSION).tar.gz

define LND_BUILD_CMDS
	$(MAKE) build $(GO_TARGET_ENV) -C $(@D)
endef

define LND_INSTALL_TARGET_CMDS
	$(MAKE) install $(GO_TARGET_ENV) -C $(@D)
endef

$(eval $(golang-package))
