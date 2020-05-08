root_dir:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
external_tree = ${root_dir}/packages
external_conf = ${root_dir}/configs
img = ${root_dir}/buildroot/output/images/sdcard.img

.DEFAULT_GOAL := build

.PHONY: target-list
target-list:
	@$(call print-info,available defconfigs:,)
	@$(call list-defconfigs,$(TOPDIR))

.PHONY: %_defconfig
%_defconfig:
	@if [ ! -f ${external_conf}/$@ ]; then \
		$(call print-info,no local config file found for:,$@); \
		$(call print-info,trying buildroot default config,); \
		cd buildroot && make defconfig BR2_EXTERNAL=${external_tree} \
		DEFCONFIG=configs/$@; \
	else \
		$(call print-info,using config file:,$@); \
		cd buildroot && make defconfig BR2_EXTERNAL=${external_tree} \
			DEFCONFIG=${external_conf}/$@; \
	fi

%:
	@echo "transfert $@ to buildroot"
	@cd buildroot && make $@

build:
ifdef silent
	@$(call print-info,starting silent build,)
	mkdir -p images
	@cd buildroot && make | grep ">>>"
else
	@$(call print-info,starting build,)
	mkdir -p images
	@cd buildroot && make
endif
	cp ${img} ./images/

.PHONY: clean-soft
clean-soft:
	@find buildroot/output/build -maxdepth 1 -type d -print | grep -Ev "host|linux-headers" | sed "1 d" | xargs rm -rf
	@rm -rf buildroot/output/images images/* buildroot/output/target

.PHONY: help
help:
	@echo "All unknown command will be transfered to buildroot"
	@echo ""
	@echo "build (default)		- compile distribution, use silent=1 for silent build"
	@echo "clean			- clean all"
	@echo "clean-soft		- clean only non host package and rebuild target folder"
	@echo "build (default)		- compile distribution, use silent=1 for silent build"
	@echo "<target>_defconfig	- set <target> defconfig"
	@echo "target-list		- list all defconfigs in ./configs"
	@echo "buildroot-help		- print buildroot help"
	@echo "help			- print this help"

.PHONY: help-buildroot
buildroot-help:
	cd buildroot && make help

define list-defconfigs
	for defconfig in configs/*_defconfig; do \
		defconfig="$${defconfig##*/}"; \
		echo $${defconfig}; \
	done;
endef

define print-info
	/bin/echo -e "- \e[1;34m$(1) \e[0m$(2)"
endef