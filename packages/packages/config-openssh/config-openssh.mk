################################################################################
#
# config-openssh
#
################################################################################

CONFIG_OPENSSH_SRC := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))src
CONFIG_OPENSSH_USER_KEY = $(call qstrip,$(BR2_CONFIG_OPENSSH_INSTALL_KEY))

config-openssh-add-key:
	@$(call MESSAGE,"Configuring openssh")
	@echo "INFO: installing ssh key $(CONFIG_OPENSSH_USER_KEY)"
	@USERS=$$(find $(TARGET_DIR)/home -maxdepth 1 -type d | tail -n+2 ); \
	for user in $$USERS; do \
		echo "INFO: installing key for user $$(basename $$user)"; \
		mkdir -p $$user/.ssh; \
		rm -rf $$user/.ssh/authorized_keys; \
		cat $(CONFIG_OPENSSH_USER_KEY) >> \
			$$user/.ssh/authorized_keys; \
	done

config-openssh-warning-banner:
	@echo "INFO: installing warning banner"
	@$(INSTALL) -m 644 $(CONFIG_OPENSSH_SRC)/banner.txt $(TARGET_DIR)/etc
	@$(call REPLACE_LINE,no default banner,warning banner,\
		$(TARGET_DIR)/etc/ssh/sshd_config)
	@$(call REPLACE_LINE,#Banner none,Banner \/etc\/banner.txt,\
		$(TARGET_DIR)/etc/ssh/sshd_config)

ifneq ($(BR2_CONFIG_OPENSSH_INSTALL_KEY),)
TARGET_CONFIGURE += config-openssh-add-key
endif

ifneq ($(BR2_CONFIG_OPENSSH_INSTALL_BANNER),)
TARGET_CONFIGURE += config-openssh-warning-banner
endif
