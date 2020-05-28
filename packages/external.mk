include $(sort $(wildcard $(BR2_EXTERNAL_PACKAGES_PATH)/packages/*/*.mk))

# Add a TARGETS_CONFIGURE before creating rootfs
# to enable the possibility to modify rootfs via makefile
# after user creation
TARGETS_ROOTFS := rootfs-create-home $(TARGET_CONFIGURE) $(TARGETS_ROOTFS)

PHONY: rootfs-create-home
rootfs-create-home:
	cat $(ROOTFS_USERS_TABLES) | while read -r line; do \
		mkdir -p $(TARGET_DIR)/$$(echo $$line | cut -d " " -f6); \
	done

# 1: file, 2: fragment, 3: str condition
# Add a fragment to a file IF str is not present
define ADD_FRAGMENT_FILE
	if ! grep -q $(3) $(1); then \
		echo "INFO: completing $(1) with fragment $(2)"; \
		cat $(2) >> $(1); \
	else \
		echo "INFO:$(1) already configured"; \
	fi
endef

# 1: str to add, 2: str to match, 3: file
# Add a line after a match in a file
define ADD_LINE_AFTER
	if ! grep -q "$$(echo $(1))" $(3); then \
		echo "INFO: adding $(1) in $(3)"; \
		sed -i '/$(2)/a$(1)' $(3); \
	else \
		echo "INFO:$(3) already configured"; \
	fi
endef

# 1: str to replace, 2: new str, 3: file
# Replace a line after a match in a file
define REPLACE_LINE
	if ! grep -q "$(2)" $(3); then \
		echo "INFO: adding $(2) in $(3)"; \
		sed -i 's/$(1)/$(2)/g' $(3); \
	else \
		echo "INFO:$(3) already configured"; \
	fi
endef
