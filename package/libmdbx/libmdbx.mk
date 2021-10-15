################################################################################
#
# libmdbx
#
################################################################################

LIBMDBX_VERSION = 0.10.3
LIBMDBX_SOURCE = libmdbx-amalgamated-$(LIBMDBX_VERSION).tar.gz
LIBMDBX_SITE = https://github.com/erthink/libmdbx/releases/download/v$(LIBMDBX_VERSION)
LIBMDBX_SUPPORTS_IN_SOURCE_BUILD = NO
LIBMDBX_LICENSE = OLDAP-2.8
LIBMDBX_LICENSE_FILES = LICENSE
LIBMDBX_REDISTRIBUTE = YES
LIBMDBX_STRIP_COMPONENTS = 0
LIBMDBX_INSTALL_STAGING = YES

# Set CMAKE_BUILD_TYPE to Release to remove -Werror and avoid a build failure
# with glibc < 2.12
LIBMDBX_CONF_OPTS = \
	-DCMAKE_BUILD_TYPE=Release \
	-DMDBX_INSTALL_MANPAGES=OFF \
	-DBUILD_FOR_NATIVE_CPU=OFF \
	-DMDBX_BUILD_CXX=$(if $(BR2_PACKAGE_LIBMDBX_CXX),ON,OFF) \
	-DMDBX_BUILD_TOOLS=$(if $(BR2_PACKAGE_LIBMDBX_TOOLS),ON,OFF)

ifeq ($(BR2_STATIC_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
LIBMDBX_CONF_OPTS += -DMDBX_INSTALL_STATIC=ON
else
LIBMDBX_CONF_OPTS += -DMDBX_INSTALL_STATIC=OFF
endif

ifeq ($(BR2_SHARED_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
LIBMDBX_CONF_OPTS += \
	-DMDBX_BUILD_SHARED_LIBRARY=ON \
	-DMDBX_LINK_TOOLS_NONSTATIC=ON
else
LIBMDBX_CONF_OPTS += \
	-DMDBX_BUILD_SHARED_LIBRARY=OFF \
	-DMDBX_LINK_TOOLS_NONSTATIC=OFF
endif

$(eval $(cmake-package))
