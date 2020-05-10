################################################################################
#
# config-hostapd
#
################################################################################

CONFIG_HOSTAPD_SRC := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))src
CONFIG_HOSTAPD_IFACE = \
	$(call qstrip,$(BR2_PACKAGE_CONFIG_HOSTAPD_IFACE))
CONFIG_HOSTAPD_SSID = \
	$(call qstrip,$(BR2_PACKAGE_CONFIG_HOSTAPD_SSID))
CONFIG_HOSTAPD_PASSPHRASE = \
	$(call qstrip,$(BR2_PACKAGE_CONFIG_HOSTAPD_PASSPHRASE))

config-hostapd:
	@echo "INFO: configuring hostapd"
	$(INSTALL) -m 755 $(CONFIG_HOSTAPD_SRC)/S90hostapd $(TARGET_DIR)/etc/init.d
	mkdir -p $(TARGET_DIR)/etc/hostapd
	$(INSTALL) -m 644 $(CONFIG_HOSTAPD_SRC)/hostapd.conf $(TARGET_DIR)/etc/hostapd

	sed -i s/interface=/interface=$(CONFIG_HOSTAPD_IFACE)/g \
		$(TARGET_DIR)/etc/hostapd/hostapd.conf
	sed -i s/ssid=/ssid=$(CONFIG_HOSTAPD_SSID)/g \
		$(TARGET_DIR)/etc/hostapd/hostapd.conf
	sed -i s/wpa_passphrase=/wpa_passphrase=$(CONFIG_HOSTAPD_PASSPHRASE)/g \
		$(TARGET_DIR)/etc/hostapd/hostapd.conf

ifeq ($(BR2_PACKAGE_CONFIG_HOSTAPD),y)
TARGET_CONFIGURE += config-hostapd
endif
