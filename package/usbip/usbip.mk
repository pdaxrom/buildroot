################################################################################
#
# usbib
#
################################################################################

ifeq ($(BR2_PACKAGE_USBIP_3_16_OR_EARLIER),y)
USBIP_BASE_DIR = drivers/staging/usbip/userspace
else
USBIP_BASE_DIR = tools/usb/usbip
endif
USBIP_SITE = $(LINUX_DIR)/$(USBIP_BASE_DIR)
USBIP_SITE_METHOD = local
USBIP_LICENSE = GPLv2
USBIP_LICENSE_FILES = COPYING
USBIP_INSTALL_STAGING = YES
USBIP_PATCH_DEPENDENCIES = linux

USBIP_DEPENDENCIES = linux libsysfs

USBIP_AUTORECONF = yes

USBIP_CONF_OPTS = --with-sysroot=$(STAGING_DIR) --without-tcp-wrappers

# This package uses autoconf, but not automake, so we need to call
# their special autogen.sh script, and have custom target and staging
# installation commands.

define USBIP_RUN_AUTOGEN
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef
USBIP_PRE_CONFIGURE_HOOKS += USBIP_RUN_AUTOGEN

define USBIP_CHECK_SRC
	@if [ ! -d $(USBIP_SITE) ]; then \
	    echo "Your kernel does not have usbip in $(USBIP_BASE_DIR)" >&2; \
	    exit 1; \
	fi
endef
USBIP_PRE_RSYNC_HOOKS += USBIP_CHECK_SRC

define USBIP_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/usbip/S09usbip $(TARGET_DIR)/etc/init.d/S09usbip
endef

ifeq ($(BR2_PACKAGE_USBIP_BIND_ALL),y)
define USBIP_INSTALL_UDEV_RULES_FILE
	$(INSTALL) -D -m 0644 package/usbip/usbip.rules $(TARGET_DIR)/etc/udev/rules.d/usbip.rules
endef

USBIP_POST_INSTALL_TARGET_HOOKS += USBIP_INSTALL_UDEV_RULES_FILE
endif # BR2_PACKAGE_USBIP_BIND_ALL

$(eval $(autotools-package))
