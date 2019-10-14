################################################################################
#
# ssh-authorized-keys
#
################################################################################

PACKAGE_SSH_AUTH_VERSION = 1.0
PACKAGE_SSH_AUTH_SITE_METHOD = local

PACKAGE_SSH_AUTH_KEY = $(call qstrip,$(BR2_PACKAGE_SSH_AUTH_KEYS_PATH))
PACKAGE_SSH_AUTH_USER = $(call qstrip,$(BR2_PACKAGE_SSH_AUTH_KEYS_USER))

define SSH_AUTHORIZED_KEYS_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/home/$(BR2_PACKAGE_SSH_AUTH_KEYS_USER)/.ssh
	cat $(PACKAGE_SSH_AUTH_KEY) > \
		$(TARGET_DIR)/home/$(PACKAGE_SSH_AUTH_USER)/.ssh/authorized_keys
endef

$(eval $(generic-package))