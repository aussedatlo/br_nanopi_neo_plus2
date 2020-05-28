################################################################################
#
# config-weston-fbdev
#
################################################################################

CONFIG_WESTON_FBDEV := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))src

.PHONY: config-weston-fbdev
config-weston-fbdev:
	@$(call MESSAGE,"Configuring weston-fbdev")
	$(INSTALL) -m 755 $(CONFIG_WESTON_FBDEV)/S30weston \
		$(TARGET_DIR)/etc/init.d/
	$(INSTALL) -m 644 $(CONFIG_WESTON_FBDEV)/weston.sh \
		$(TARGET_DIR)/etc/profile.d/
	mkdir -p $(TARGET_DIR)/etc/xdg/weston/
	$(INSTALL) -m 644 $(CONFIG_WESTON_FBDEV)/weston.ini \
		$(TARGET_DIR)/etc/xdg/weston/


ifeq ($(BR2_CONFIG_WESTON_FBDEV),y)
TARGET_CONFIGURE += config-weston-fbdev
endif
