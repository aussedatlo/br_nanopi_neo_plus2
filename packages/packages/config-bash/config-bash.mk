################################################################################
#
# config-bash
#
################################################################################

CONFIG_OPENSSH_USER_KEY = $(call qstrip,$(BR2_CONFIG_OPENSSH_INSTALL_KEY))

CONFIG_BASH_SRC := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))/src

config-bash-add-bashrc:
	@$(call MESSAGE,"Configuring bash")
	@USERS=$$(find $(TARGET_DIR)/home -maxdepth 1 -type d | tail -n+2 ); \
	for user in $$USERS $(TARGET_DIR)/root; do \
		echo "INFO: installing .bashrc for user $$(basename $$user)"; \
		cp $(CONFIG_BASH_SRC)/bashrc $$user/.bashrc; \
	done

config-bash-profile:
	@USERS=$$(find $(TARGET_DIR)/home -maxdepth 1 -type d | tail -n+2 ); \
	for user in $$USERS $(TARGET_DIR)/root; do \
		if ! grep -q ".bashrc" $$user/.profile; then \
			echo "INFO: completing .profile for user $$(basename $$user)"; \
			cat $(CONFIG_BASH_SRC)/profile.fragment >> $$user/.profile; \
		fi; \
	done


ifeq ($(BR2_CONFIG_BASH),y)
TARGET_CONFIGURE += config-bash-add-bashrc config-bash-profile
endif
