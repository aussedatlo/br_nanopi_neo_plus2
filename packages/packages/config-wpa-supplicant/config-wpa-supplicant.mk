################################################################################
#
# config-wpa-supplicant
#
################################################################################

CONFIG_WPA_SUPPLICANT_SRC := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))src
CONFIG_WPA_SUPPLICANT_SSID = \
	$(call qstrip,$(BR2_CONFIG_WPA_SUPPLICANT_SSID))
CONFIG_WPA_SUPPLICANT_PSK = \
	$(call qstrip,$(BR2_CONFIG_WPA_SUPPLICANT_PSK))

.PHONY: config-wpa-supplicant
config-wpa-supplicant:
	@$(call MESSAGE,"Configuring wpa-supplicant")
	@$(call ADD_FRAGMENT_FILE,\
		$(TARGET_DIR)/etc/network/interfaces,\
		$(CONFIG_WPA_SUPPLICANT_SRC)/interfaces.fragment,\
		"wlan0");
	@$(INSTALL) -m 644 $(CONFIG_WPA_SUPPLICANT_SRC)/wpa_supplicant.conf \
		$(TARGET_DIR)/etc
	@$(call REPLACE_LINE,ssid=,ssid=\"$(CONFIG_WPA_SUPPLICANT_SSID)\",\
		$(TARGET_DIR)/etc/wpa_supplicant.conf)
	@$(call REPLACE_LINE,psk=,psk=\"$(CONFIG_WPA_SUPPLICANT_PSK)\",\
		$(TARGET_DIR)/etc/wpa_supplicant.conf)

ifeq ($(BR2_CONFIG_WPA_SUPPLICANT),y)
TARGET_CONFIGURE += config-wpa-supplicant
endif
