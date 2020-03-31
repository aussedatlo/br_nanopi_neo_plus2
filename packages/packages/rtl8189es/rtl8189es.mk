################################################################################
#
# rtl8189es
#
################################################################################

# Hash commit git
RTL8189ES_VERSION = e18d6e5b2368dff0d439e89860bf27169040476b
RTL8189ES_SITE = https://github.com/jwrdegoede/rtl8189ES_linux.git
RTL8189ES_SITE_METHOD = git
RTL8189ES_LICENSE = CLOSED
RTL8189ES_DEPENDENCIES = linux

RTL8189ES_INSTALL_PATH = \
	$(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/kernel/net/realtek

define RTL8189ES_BUILD_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KSRC=$(LINUX_DIR)
endef

define RTL8189ES_INSTALL_TARGET_CMDS
	mkdir -p $(RTL8189ES_INSTALL_PATH)
    $(INSTALL) -m 0744 $(@D)/8189es.ko  $(RTL8189ES_INSTALL_PATH)
endef

$(eval $(kernel-module))
$(eval $(generic-package))
