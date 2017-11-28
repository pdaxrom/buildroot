################################################################################
#
# pptpd
#
################################################################################

PPTPD_VERSION = 1.4.0
PPTPD_SOURCE = pptpd-$(PPTPD_VERSION).tar.gz
PPTPD_SITE = https://downloads.sourceforge.net/project/poptop/pptpd/pptpd-${PPTPD_VERSION}
PPTPD_INSTALL_STAGING = YES
PPTPD_DEPENDENCIES = pppd
PPTPD_LICENSE = GPL-2.0
PPTPD_LICENSE_FILES = COPYING.LIB

PPTPD_CONF_OPTS = --enable-bcrelay

PPTPD_CONF_ENV = \
	ac_cv_header_libintl_h=no \
	CFLAGS="$(TARGET_CFLAGS) -I$(PPPD_DIR)"

PPTPD_MAKE_OPTS = COPTS="$(TARGET_CFLAGS) -I$(PPPD_DIR)" CC=$(TARGET_CC)

PPTPD_INSTALL_STAGING_OPTS = DESTDIR=$(STAGING_DIR) INSTALL="install" install

PPTPD_TARGET_BINS = bcrelay pptpctrl pptpd

define PPTPD_INSTALL_TARGET_CMDS
	for sbin in $(PPTPD_TARGET_BINS); do \
		$(INSTALL) -D $(PPTPD_DIR)/$$sbin \
			$(TARGET_DIR)/usr/sbin/$$sbin; \
	done
	$(INSTALL) -m 644 -D $(PPTPD_DIR)/plugins/pptpd-logwtmp.so \
		$(TARGET_DIR)/usr/lib/pptpd/pptpd-logwtmp.so
	$(INSTALL) -m 644 -D package/pptpd/files/pptpd.conf \
		$(TARGET_DIR)/etc/pptpd.conf
	$(INSTALL) -m 644 -D package/pptpd/files/options.pptpd \
		$(TARGET_DIR)/etc/ppp/options.pptpd
	$(INSTALL) -m 755 -D package/pptpd/files/pptpd.init \
		$(TARGET_DIR)/etc/init.d/S60pptpd
endef

$(eval $(autotools-package))
