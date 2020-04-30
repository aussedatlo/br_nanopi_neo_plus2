################################################################################
#
# config-iptables
#
################################################################################

CONFIG_IPTABLES_SRC := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))src
CONFIG_IPTABLES_PORTS = \
	$(call qstrip,$(BR2_PACKAGE_CONFIG_IPTABLES_PORTS))

config-iptables:
	@$(call MESSAGE,"Configuring iptables")
	@echo "INFO: installing default S35iptables init script"
	@$(INSTALL) -m 755 $(CONFIG_IPTABLES_SRC)/S35iptables \
		$(TARGET_DIR)/etc/init.d
	@for PORT in $(CONFIG_IPTABLES_PORTS); do \
		echo "INFO: adding port $$PORT"; \
		echo "" >> $(TARGET_DIR)/etc/init.d/S35iptables; \
		echo "# Allow port $$PORT" >> $(TARGET_DIR)/etc/init.d/S35iptables; \
		echo "iptables -t filter -A OUTPUT -p TCP --sport $$PORT -j ACCEPT" \
			>> $(TARGET_DIR)/etc/init.d/S35iptables; \
		echo "iptables -t filter -A INPUT -p TCP --dport $$PORT -j ACCEPT" \
			>> $(TARGET_DIR)/etc/init.d/S35iptables; \
	done

config-iptables-ping:
	@echo "INFO: Allow ping requests"
	echo "" >> $(TARGET_DIR)/etc/init.d/S35iptables; \
	echo "# Allow ping requests" >> $(TARGET_DIR)/etc/init.d/S35iptables; \
	echo "iptables -A OUTPUT -p icmp -j ACCEPT" \
		>> $(TARGET_DIR)/etc/init.d/S35iptables; \
	echo "iptables -A INPUT  -p icmp  -j ACCEPT" \
			>> $(TARGET_DIR)/etc/init.d/S35iptables; \

config-iptables-dns:
	@echo "INFO: Allow ping requests"
	echo "" >> $(TARGET_DIR)/etc/init.d/S35iptables; \
	echo "# Allow DNS requests" >> $(TARGET_DIR)/etc/init.d/S35iptables; \
	echo "iptables -A INPUT -p udp --dport 53 -j ACCEPT" \
		>> $(TARGET_DIR)/etc/init.d/S35iptables;
	echo "iptables -A OUTPUT -p udp --dport 53 -j ACCEPT" \
			>> $(TARGET_DIR)/etc/init.d/S35iptables;

config-iptables-allow-output:
	@$(call REPLACE_LINE,iptables -P OUTPUT DROP,iptables -P OUTPUT ACCEPT,\
		$(TARGET_DIR)/etc/init.d/S35iptables)
	@echo "INFO: allowing output traffic"

ifeq ($(BR2_PACKAGE_CONFIG_IPTABLES),y)
TARGET_CONFIGURE += config-iptables
endif

ifeq ($(BR2_PACKAGE_CONFIG_IPTABLES_ALLOW_PING),y)
TARGET_CONFIGURE += config-iptables-ping
endif

ifeq ($(BR2_PACKAGE_CONFIG_IPTABLES_ALLOW_DNS),y)
TARGET_CONFIGURE += config-iptables-dns
endif

ifeq ($(BR2_PACKAGE_CONFIG_IPTABLES_INPUT),y)
TARGET_CONFIGURE += config-iptables-allow-output
endif
