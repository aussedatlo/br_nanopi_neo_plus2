################################################################################
#
# oh-my-zsh
#
################################################################################

OH_MY_ZSH_VERSION = fd786291bab7468c7cdd5066ac436218a1fba9e2
OH_MY_ZSH_SITE = https://github.com/ohmyzsh/ohmyzsh
OH_MY_ZSH_SITE_METHOD = git
OH_MY_ZSH_DEPENDENCIES = linux

OH_MY_ZSH_INSTALL_PATH = $(TARGET_DIR)/usr/share/oh-my-zsh

define OH_MY_ZSH_INSTALL_TARGET_CMDS
	mkdir -p $(OH_MY_ZSH_INSTALL_PATH)
	cp -r $(@D)/* $(OH_MY_ZSH_INSTALL_PATH)
endef

$(eval $(generic-package))
