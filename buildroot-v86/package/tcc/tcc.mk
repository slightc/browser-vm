################################################################################
#
# nled
#
################################################################################

TCC_VERSION = 6120656cbf6d772fd30a18d5ba950d39c99ba226
TCC_SITE = https://repo.or.cz/tinycc.git/snapshot
# TCC_SITE = http://download.savannah.gnu.org/releases/tinycc
TCC_SOURCE = ${TCC_VERSION}.tar.gz
TCC_LICENSE = GPL-2.0+
TCC_INSTALL_STAGING = YES

# We need to override the C compiler used in the Makefile to 
# use buildroot's cross-compiler instead of cc.  Switch cc to $(CC)
# so we can override the variable via env vars.
# cp ${BR2_EXTERNAL_v86_PATH}/package/tcc/patch/* $(@D)/
define TCC_MAKEFILE_FIXUP
       (cd $(@D) && $(TARGET_MAKE_ENV) ./configure \
         --prefix=/usr \
         --cross-prefix=i686-linux- \
         --cpu=i386 \
         --crtprefix=/usr/lib \
         --config-predefs=no \
         --config-uClibc \
         --config-bcheck=no)
endef
# (cd $(@D) && $(TARGET_MAKE_ENV) ./configure --prefix=/usr --cross-prefix=i686-linux- --cpu=i386 )

TCC_PRE_BUILD_HOOKS += TCC_MAKEFILE_FIXUP

define TCC_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) i386-libtcc1-usegcc=yes
endef

# define TCC_INSTALL_TARGET_CMDS
# 	$(INSTALL) -D -m 0755 $(@D)/tcc $(TARGET_DIR)/usr/bin/tcc
# endef
define TCC_INSTALL_TARGET_CMDS
	DESTDIR=$(TARGET_DIR) $(MAKE) -C $(@D) install
endef

TCC_GLIBC_LIBS = \
       *crt*.o *_nonshared.a \
       libBrokenLocale.so libanl.so libbfd.so libc.so libcrypt.so libdl.so \
       libm.so libnss_compat.so libnss_db.so libnss_files.so libnss_hesiod.so \
       libpthread.so libresolv.so librt.so libthread_db.so libutil.so

define TCC_INSTALL_LIBS
       for libpattern in $(TCC_GLIBC_LIBS); do \
               $(call copy_toolchain_lib_root,$$libpattern) ; \
       done
endef
TCC_POST_INSTALL_TARGET_HOOKS += TCC_INSTALL_LIBS

define TCC_INSTALL_STAGING_CMDS
       DESTDIR=$(STAGING_DIR) $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
