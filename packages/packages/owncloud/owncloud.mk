################################################################################
#
# owncloud-core
#
################################################################################

OWNCLOUD_VERSION = 10.4.1
OWNCLOUD_SOURCE = v$(OWNCLOUD_VERSION).tar.gz
OWNCLOUD_SITE = https://github.com/owncloud/core/archive

# OWNCLOUD_VERSION = 9d745bbdf5cd074774a5c18bf348217afa5979aa
# OWNCLOUD_SITE = $(call github,owncloud,core,$(OWNCLOUD_VERSION))
OWNCLOUD_LICENSE = AGPL
OWNCLOUD_LICENSE_FILES = COPYING

define OWNCLOUD_INSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/var/www/owncloud
	mkdir -p $(TARGET_DIR)/var/www
	cp -a $(@D) $(TARGET_DIR)/var/www/owncloud
endef

define OWNCLOUD_PERMISSIONS
/var/www/owncloud r -1 www-data www-data - - - - -
endef

$(eval $(generic-package))
