################################################################################
#
# config-sudo-pam
#
################################################################################

config-sudo-pam:
	@$(call MESSAGE,"Configuring pam with sudo")
	@$(call REPLACE_LINE,use_uid,use_uid group=sudo,\
		$(TARGET_DIR)/etc/pam.d/sudo)

ifeq ($(BR2_CONFIG_SUDO_PAM),y)
TARGET_CONFIGURE += config-sudo-pam
endif
