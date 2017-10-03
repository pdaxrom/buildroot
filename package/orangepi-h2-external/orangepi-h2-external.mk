################################################################################
#
# sunxi-boards
#
################################################################################

ORANGEPI_H2_EXTERNAL_VERSION = 1ddcb796ad38ef4baf029177613f737f05aba1ff
ORANGEPI_H2_EXTERNAL_SITE = $(call github,orangepi-xunlong,OrangePiH2_external,$(ORANGEPI_H2_EXTERNAL_VERSION))
ORANGEPI_H2_EXTERNAL_DEPENDENCIES =
ORANGEPI_H2_EXTERNAL_INSTALL_IMAGES = YES
ORANGEPI_H2_EXTERNAL_INSTALL_TARGET = NO

define ORANGEPI_H2_EXTERNAL_INSTALL_IMAGES_CMDS
	mkdir -p $(TARGET_DIR)/lib/firmware/xr819
	cp -f $(@D)/Legacy_patch/boot_xr819.bin $(TARGET_DIR)/lib/firmware/xr819
	cp -f $(@D)/Legacy_patch/fw_xr819.bin   $(TARGET_DIR)/lib/firmware/xr819
	cp -f $(@D)/Legacy_patch/sdd_xr819.bin  $(TARGET_DIR)/lib/firmware/xr819
endef

$(eval $(generic-package))
