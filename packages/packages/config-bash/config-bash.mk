################################################################################
#
# config-bash
#
################################################################################

CONFIG_BASH_SRC := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))src

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
		$(call ADD_FRAGMENT_FILE,\
			$$user/.profile,\
			$(CONFIG_BASH_SRC)/profile.fragment,\
			".bashrc"); \
	done


ifeq ($(BR2_CONFIG_BASH),y)
TARGET_CONFIGURE += config-bash-add-bashrc config-bash-profile
endif
