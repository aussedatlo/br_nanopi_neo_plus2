include $(sort $(wildcard $(BR2_EXTERNAL_PACKAGES_PATH)/packages/*/*.mk))


# Add a TARGETS_CONFIGURE before creating rootfs
# to enable the possibility to modify rootfs via makefile
# after user creation
TARGETS_ROOTFS := rootfs-common $(TARGET_CONFIGURE) $(TARGETS_ROOTFS)
