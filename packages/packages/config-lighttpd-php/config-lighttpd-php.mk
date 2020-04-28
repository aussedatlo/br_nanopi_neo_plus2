################################################################################
#
# config-lighttpd-php
#
################################################################################

CONFIG_LIGHTTPD_PHP_SRC := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))src
CONFIG_LIGHTTPD_PHP_EXAMPLE_PATH = $(TARGET_DIR)/var/www/example

config-lighttpd-php-base:
	@$(call MESSAGE,"Configuring lighttpd with php")
	@$(call ADD_FRAGMENT_FILE,\
		$(TARGET_DIR)/etc/lighttpd/lighttpd.conf,\
		$(CONFIG_LIGHTTPD_PHP_SRC)/lighttpd.conf.fragment,\
		"fastcgi.server")
	@$(call ADD_LINE_AFTER,\
		\$(space)\$(space)\"mod_fastcgi\"$(comma),\
		\"mod_access\",\
		$(TARGET_DIR)/etc/lighttpd/modules.conf)

config-lighttpd-php-example:
	@echo "INFO: creating example php file in /var/www/example"
	@mkdir -p $(CONFIG_LIGHTTPD_PHP_EXAMPLE_PATH)
	@echo "<?php phpinfo(); ?>" > $(CONFIG_LIGHTTPD_PHP_EXAMPLE_PATH)/index.php

ifeq ($(BR2_PACKAGE_CONFIG_LIGHTTPD_PHP),y)
TARGET_CONFIGURE += config-lighttpd-php-base
endif

ifeq ($(BR2_PACKAGE_CONFIG_LIGHTTPD_PHP_EXAMPLE),y)
TARGET_CONFIGURE += config-lighttpd-php-example
endif
