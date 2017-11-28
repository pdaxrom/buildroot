################################################################################
#
# ifmetric
#
################################################################################

IFMETRIC_VERSION = 0.3
IFMETRIC_SOURCE = ifmetric-$(IFMETRIC_VERSION).tar.gz
IFMETRIC_SITE = http://0pointer.de/lennart/projects/ifmetric
IFMETRIC_LICENSE = GPL-2.0
IFMETRIC_LICENSE_FILES = COPYING

IFMETRIC_CONF_OPTS = --disable-lynx --disable-xmltoman

define IFMETRIC_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 -D $(IFMETRIC_DIR)/src/ifmetric \
		$(TARGET_DIR)/usr/sbin/ifmetric
endef

$(eval $(autotools-package))
