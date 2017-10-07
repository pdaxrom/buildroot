################################################################################
#
# stella
#
################################################################################

PYLDIN601_VERSION = 3.4
PYLDIN601_SITE = $(call github,pdaxrom,pyldin601,$(PYLDIN601_VERSION))
#PYLDIN601_SITE_METHOD = git

#PYLDIN601_LICENSE = GPL-2.0+
#PYLDIN601_LICENSE_FILES = Copyright.txt License.txt

PYLDIN601_DEPENDENCIES = sdl2 sdl2_image zlib

define PYLDIN601_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) CC=${GNU_TARGET_NAME}-gcc OPT_STRIP=-s
endef

define PYLDIN601_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
endef

ifneq ($(BR2_PACKAGE_PYLDIN601_ALL_FLOPPIES),y)
define PYLDIN601_REMOVE_ALL_FLOPPIES
	rm -f $(TARGET_DIR)/usr/share/pyldin/Floppy/*
endef
PYLDIN601_POST_INSTALL_TARGET_HOOKS += PYLDIN601_REMOVE_ALL_FLOPPIES
endif

ifeq ($(BR2_PACKAGE_PYLDIN601_GAMES),y)
define PYLDIN601_INSTALL_GAMES_FLOPPY
	cp -f $(@D)/native/Floppy/games.imz $(TARGET_DIR)/usr/share/pyldin/Floppy/
endef
PYLDIN601_POST_INSTALL_TARGET_HOOKS += PYLDIN601_INSTALL_GAMES_FLOPPY
endif

$(eval $(generic-package))
