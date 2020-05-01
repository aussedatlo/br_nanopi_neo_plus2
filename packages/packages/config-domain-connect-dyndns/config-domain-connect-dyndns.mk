################################################################################
#
# config-domain-connect-dyndns
#
################################################################################

CONFIG_DOMAIN_CONNECT_DDNS_SRC := \
	$(dir $(abspath $(lastword $(MAKEFILE_LIST))))src

config-domain-connect-dyndns:
	@$(call MESSAGE,"Configuring cron for domain-connect-dyndns")
	@echo "INFO: installing cron script"
	@$(INSTALL) -m 755 \
		$(CONFIG_DOMAIN_CONNECT_DDNS_SRC)/domain-connect-dyndns-update \
		$(TARGET_DIR)/etc/cron.hourly

ifeq ($(BR2_PACKAGE_CONFIG_DOMAIN_CONNECT_DYNDNS),y)
TARGET_CONFIGURE += config-domain-connect-dyndns
endif
