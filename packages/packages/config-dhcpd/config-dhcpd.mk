################################################################################
#
# config-dhcpd
#
################################################################################

CONFIG_DHCPD_SRC := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))src
CONFIG_DHCPD_PORTS = \
	$(call qstrip,$(BR2_PACKAGE_CONFIG_DHCPD_PORTS))

config-dhcpd:
	@echo "IINFO: configuring dhcpd"
	mkdir -p $(TARGET_DIR)/etc/dhcp
	$(INSTALL) -m 644 $(CONFIG_DHCPD_SRC)/dhcpd.conf $(TARGET_DIR)/etc/dhcp
	sed -i s/SUBNET/$(call qstrip,$(BR2_PACKAGE_CONFIG_DHCPD_SUBNET))/g \
		$(TARGET_DIR)/etc/dhcp/dhcpd.conf
	sed -i s/NETMASK/$(call qstrip,$(BR2_PACKAGE_CONFIG_DHCPD_NETMASK))/g \
		$(TARGET_DIR)/etc/dhcp/dhcpd.conf
	sed -i s/RANGE_MIN/$(call qstrip,$(BR2_PACKAGE_CONFIG_DHCPD_RANGE_MIN))/g \
		$(TARGET_DIR)/etc/dhcp/dhcpd.conf
	sed -i s/RANGE_MAX/$(call qstrip,$(BR2_PACKAGE_CONFIG_DHCPD_RANGE_MAX))/g \
		$(TARGET_DIR)/etc/dhcp/dhcpd.conf
	sed -i s/DOMAIN_NAME/$(call qstrip,$(BR2_PACKAGE_CONFIG_DHCPD_DOMAIN_NAME))/g \
		$(TARGET_DIR)/etc/dhcp/dhcpd.conf
	sed -i s/ROUTERS/$(call qstrip,$(BR2_PACKAGE_CONFIG_DHCPD_ROUTERS))/g \
		$(TARGET_DIR)/etc/dhcp/dhcpd.conf

ifeq ($(BR2_PACKAGE_CONFIG_DHCPD),y)
TARGET_CONFIGURE += config-dhcpd
endif
