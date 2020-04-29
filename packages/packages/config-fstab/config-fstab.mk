################################################################################
#
# config-fstab
#
################################################################################

CONFIG_FSTAB_DEVICE = \
	$(call qstrip,$(BR2_PACKAGE_CONFIG_FSTAB_DEVICE))
CONFIG_FSTAB_MOUNT_POINT = \
	$(call qstrip,$(BR2_PACKAGE_CONFIG_FSTAB_MOUNT_POINT))
CONFIG_FSTAB_TYPE = \
	$(call qstrip,$(BR2_PACKAGE_CONFIG_FSTAB_TYPE))

config-fstab:
	@$(call MESSAGE,"Configuring fstab")
	@mkdir -p $(TARGET_CONFIGURE)$(CONFIG_FSTAB_MOUNT_POINT)
	@if ! grep $(CONFIG_FSTAB_DEVICE) $(TARGET_DIR)/etc/fstab; then \
		echo "INFO: configuring fstab for device $(CONFIG_FSTAB_DEVICE)"; \
		printf "%-15s %-15s %-7s %-15s %-7s %s\n" \
			$(CONFIG_FSTAB_DEVICE) \
			$(CONFIG_FSTAB_MOUNT_POINT) \
			$(CONFIG_FSTAB_TYPE) \
			data=journal \
			0 2 >> $(TARGET_DIR)/etc/fstab; \
	else \
		echo "INFO: fstab already configured"; \
	fi

ifeq ($(BR2_PACKAGE_CONFIG_FSTAB),y)
TARGET_CONFIGURE += config-fstab
endif
