################################################################################
#
# km-rtl8189es
#
################################################################################

KM_RTL8189ES_VERSION = 2c8d44ae26485052f39d933a3a132b3ff395803a
KM_RTL8189ES_SITE = https://github.com/jwrdegoede/rtl8189ES_linux
KM_RTL8189ES_SITE_METHOD = git
KM_RTL8189ES_DEPENDENCIES = linux

KM_RTL8189ES_LINUX_VERSION = $(LINUX_VERSION_PROBED)
KM_RTL8189ES_INSTALL_PATH = \
	$(TARGET_DIR)/lib/modules/$(KM_RTL8189ES_LINUX_VERSION)/kernel/net/realtek/

define KM_RTL8189ES_BUILD_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KSRC=$(LINUX_DIR)
endef

define KM_RTL8189ES_INSTALL_TARGET_CMDS
	mkdir -p $(KM_RTL8189ES_INSTALL_PATH)
	cp $(@D)/8189es.ko $(KM_RTL8189ES_INSTALL_PATH)
endef

$(eval $(kernel-module))
$(eval $(generic-package))
