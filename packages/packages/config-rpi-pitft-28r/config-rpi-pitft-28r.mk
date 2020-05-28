################################################################################
#
# config-rpi-pitft-28r
#
################################################################################

CONFIG_RPI_PITFT_28R := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))src


.PHONY: config-rpi-pitft-28r
config-rpi-pitft-28r:
	@$(call MESSAGE,"Configuring pi-pitft-28r")
	@$(call ADD_FRAGMENT_FILE,\
		$(BINARIES_DIR)/rpi-firmware/config.txt,\
		$(CONFIG_RPI_PITFT_28R)/config.txt.fragment,\
		"pitft")
	@$(call REPLACE_LINE,rootwait,rootwait fbcon=map:10,\
		$(BINARIES_DIR)/rpi-firmware/cmdline.txt)

.PHONY: config-rpi-pitft-28r-udev
config-rpi-pitft-28r-udev:
	@$(INSTALL) -m 644 $(CONFIG_RPI_PITFT_28R)/01-rotate-touchscreen-90.rules \
		$(TARGET_DIR)/etc/udev/rules.d/


ifeq ($(BR2_CONFIG_RPI_PITFT_28R),y)
TARGET_CONFIGURE += config-rpi-pitft-28r
endif

ifeq ($(BR2_PACKAGE_HAS_UDEV)$(BR2_CONFIG_RPI_PITFT_28R),yy)
TARGET_CONFIGURE += config-rpi-pitft-28r-udev
endif
