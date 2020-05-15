################################################################################
#
# config-oh-my-zsh
#
################################################################################

.PHONY: config-oh-my-zsh
config-oh-my-zsh:
	@$(call MESSAGE,"Configuring oh-my-zsh")
	USERS=$$(find $(TARGET_DIR)/home -maxdepth 1 -type d | tail -n+2 ); \
	for user in $$USERS $(TARGET_DIR)/root; do \
		echo "INFO: installing .zshrc for user $$(basename $$user)"; \
		cp $(TARGET_DIR)/usr/share/oh-my-zsh/templates/zshrc.zsh-template \
			$$user/.zshrc; \
		$(call REPLACE_LINE,\$$HOME\/.oh-my-zsh,\/usr\/share\/oh-my-zsh,\
		$$user/.zshrc); \
		$(call REPLACE_LINE,robbyrussell,dieter,$$user/.zshrc); \
	done


ifeq ($(BR2_CONFIG_OH_MY_ZSH),y)
TARGET_CONFIGURE += config-oh-my-zsh
endif
