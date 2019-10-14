root_dir:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
external_tree = ${root_dir}/packages
external_conf = ${root_dir}/configs

.DEFAULT_GOAL := build


TARGET_SAVED_FILE := .target
ifneq (,$(wildcard $(TARGET_SAVED_FILE)))
TARGET_SAVED := $(shell cat .target)
endif
ifeq ($(TARGET),)
TARGET := $(TARGET_SAVED)
endif

.PHONY: target
target:
	@$(call print-info,Target is:,${TARGET})

.PHONY: target-list
target-list:
	@$(call list-defconfigs,$(TOPDIR))

build: target init-defconfig
	@$(call print-info,Building:,${TARGET}_defconfig)
	@cd buildroot && make 2> /dev/null | grep ">>>"
	@mkdir -p ./images
	cp ./buildroot/output/images/*.img ./images

.PHONY: check-defconfig
check-defconfig:
	@if [ ! -f ${external_conf}/${TARGET}_defconfig ]; then \
		echo TARGET is unknown; \
		exit 1; \
	fi

.PHONY: init-defconfig
init-defconfig: check-defconfig .target
	@$(call print-info,Setting config file:,$(TARGET)_defconfig)
	@cd buildroot && make BR2_EXTERNAL=${external_tree} defconfig BR2_DEFCONFIG=${external_conf}/$(TARGET)_defconfig

.target:
	@echo $(TARGET) > .target

%:
	cd buildroot && make $@

.PHONY: clean
clean:
	rm .target
	cd buildroot && make clean

.PHONY: help
help:
	@echo "First use, don't forget to set TARGET variable"
	@echo "If you set it one time, she will be stored in"
	@echo ".target file, you don't need to set it each time."
	@echo ""
	@echo "build	 		- make target"
	@echo "init-defconfig		- set a defconfig to buildroot config"
	@echo "check-defconfig		- check if config exist"
	@echo "target-list		- list all defconfigs in ./configs"
	@echo "target			- print actual defconfig in use"
	@echo "help-buildroot		- print buildroot help"

.PHONY: help-buildroot
help-buildroot:
	cd buildroot && make help

define list-defconfigs
	for defconfig in configs/*_defconfig; do \
		defconfig="$${defconfig##*/}"; \
		echo - $${defconfig}; \
	done; \

endef

define print-info
	/bin/echo -e "\n\e[1;34m$(1) \e[0m$(2)"
endef