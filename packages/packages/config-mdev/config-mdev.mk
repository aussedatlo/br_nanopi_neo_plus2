################################################################################
#
# config-mdev
#
################################################################################

CONFIG_MDEV_SRC := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))src

config-mdev:
	@$(call MESSAGE,"Configuring mdev")
	@mkdir -p $(TARGET_DIR)/media
	@if ! grep /media $(TARGET_DIR)/etc/fstab; then \
		echo "INFO: configuring fstab"; \
		printf "%-15s %-15s %-7s %-15s %-7s %s\n" \
			tmpfs \
			/media \
			tmpfs \
			default \
			0 0 >> $(TARGET_DIR)/etc/fstab; \
	else \
		echo "INFO: fstab already configured"; \
	fi
	@$(call ADD_FRAGMENT_FILE,\
		$(TARGET_DIR)/etc/mdev.conf,\
		$(CONFIG_MDEV_SRC)/mdev.conf.fragment,\
		"automount removable devices")
	@echo "INFO: installing automounter.sh"
	@mkdir -p $(TARGET_DIR)/lib/mdev
	@$(INSTALL) -m 755 $(CONFIG_MDEV_SRC)/automounter.sh \
		$(TARGET_DIR)/lib/mdev


ifeq ($(BR2_CONFIG_MDEV),y)
TARGET_CONFIGURE += config-mdev
endif
