################################################################################
#
# pjsip
#
################################################################################

PJSIP_SITE = $(call github,pjsip,pjproject,$(PJSIP_VERSION))
PJSIP_VERSION = 2.14.1

PJSIP_LICENSE = GPL-2.0-only
PJSIP_LICENSE_FILES = COPYING

PJSIP_CONF_OPTS = \
	--enable-shared

#define PJSIP_BUILD_CMDS
#	$(MAKE) dep -C $(@D)
#	$(MAKE) clean -C $(@D)
#	$(MAKE) -C $(@D)
#endef

#$(eval $(generic-package))
$(eval $(autotools-package))
