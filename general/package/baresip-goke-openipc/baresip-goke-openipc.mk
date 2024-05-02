#############################################################
#
# baresip-goke-openipc
#
#############################################################

BARESIP_GOKE_OPENIPC_SITE = $(call github,seyboman,baresip,$(BARESIP_GOKE_OPENIPC_VERSION))
BARESIP_GOKE_OPENIPC_VERSION = goke_modules_v0.4

BARESIP_GOKE_OPENIPC_DEPENDENCIES = libre-openipc librem-openipc zlib hisilicon-opensdk goke-osdrv-gk7205v200

BARESIP_GOKE_OPENIPC_MAKE_ENV = \
	$(TARGET_CONFIGURE_OPTS) \
	SYSROOT=$(STAGING_DIR)/usr \
	SYSROOT_LOCAL=$(STAGING_DIR)/usr \
	LD="$(TARGET_CC)" \
	LFLAGS="$(TARGET_LDFLAGS)"

BARESIP_GOKE_OPENIPC_MAKE_ARGS = \
	LIBRE_MK="$(STAGING_DIR)/usr/share/re/re.mk" \
	LIBRE_INC="$(STAGING_DIR)/usr/include/re" \
	LIBRE_SO="$(STAGING_DIR)/usr/lib" \
	LIBREM_MK="$(STAGING_DIR)/usr/share/rem/rem.mk" \
	LIBREM_INC="$(STAGING_DIR)/usr/include/rem" \
	LIBREM_SO="$(STAGING_DIR)/usr/lib"

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
BARESIP_GOKE_OPENIPC_DEPENDENCIES += alsa-lib
endif

#ifeq ($(BR2_PACKAGE_FFMPEG_SWSCALE),y)
ifeq ($(BR2_PACKAGE_FFMPEG_OPENIPC),y)
BARESIP_GOKE_OPENIPC_DEPENDENCIES += ffmpeg-openipc
BARESIP_GOKE_OPENIPC_MAKE_ENV += \
	CFLAGS+=-DCODEC_TYPE_VIDEO=AVMEDIA_TYPE_VIDEO
endif

ifeq ($(BR2_PACKAGE_LIBSNDFILE),y)
BARESIP_GOKE_OPENIPC_DEPENDENCIES += libsndfile
endif

ifeq ($(BR2_PACKAGE_SPEEX),y)
BARESIP_GOKE_OPENIPC_DEPENDENCIES += speex
endif

ifeq ($(BR2_PACKAGE_UTIL_LINUX_LIBUUID),y)
BARESIP_GOKE_OPENIPC_DEPENDENCIES += util-linux
endif

ifeq ($(BR2_PACKAGE_XORG7),y)
BARESIP_GOKE_OPENIPC_DEPENDENCIES += xlib_libXext
endif

define BARESIP_GOKE_OPENIPC_BUILD_CMDS
	$(BARESIP_GOKE_OPENIPC_MAKE_ENV) $(MAKE) $(BARESIP_GOKE_OPENIPC_MAKE_ARGS) -C $(@D) all
endef

define BARESIP_GOKE_OPENIPC_CLEAN_CMDS
	$(BARESIP_GOKE_OPENIPC_MAKE_ENV) $(MAKE) $(BARESIP_GOKE_OPENIPC_MAKE_ARGS) -C $(@D) clean
endef

define BARESIP_GOKE_OPENIPC_INSTALL_TARGET_CMDS
	$(BARESIP_GOKE_OPENIPC_MAKE_ENV) DESTDIR=$(TARGET_DIR) $(MAKE) $(BARESIP_GOKE_OPENIPC_MAKE_ARGS) -C $(@D) install
endef

define BARESIP_GOKE_OPENIPC_UNINSTALL_TARGET_CMDS
	$(RM) $(TARGET_DIR)/usr/bin/baresip
	$(RM) -r $(TARGET_DIR)/usr/lib/baresip
	$(RM) -r $(TARGET_DIR)/usr/share/baresip
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
