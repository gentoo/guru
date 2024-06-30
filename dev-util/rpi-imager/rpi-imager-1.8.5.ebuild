# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Raspberry Pi Imaging Utility"
HOMEPAGE="
https://www.raspberrypi.com/software/
https://github.com/raspberrypi/rpi-imager
"
SRC_URI="https://github.com/raspberrypi/rpi-imager/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}/src"

LICENSE="Apache-2.0"
SLOT="0"

KEYWORDS="~amd64"
IUSE="gnutls qt5 qt6 zlib lzma zstd brotli bzip2 xz dbus gnutls openssl -telemetry"
REQUIRED_USE=" || ( qt5 qt5 ) || ( gnutls openssl )"

RDEPEND="
	app-crypt/p11-kit
	dev-libs/double-conversion
	dev-libs/glib
	dev-libs/gmp
	dev-libs/icu
	dev-libs/libffi
	dev-libs/libpcre2
	dev-libs/libtasn1
	dev-libs/libunistring
	dev-libs/libxml2
	dev-libs/nettle
	media-gfx/graphite2
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libglvnd
	media-libs/libpng
	net-dns/c-ares
	net-dns/libidn2
	net-libs/libpsl
	net-libs/nghttp2
	sys-apps/acl
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXdmcp
"

RDEPEND="
	sys-apps/util-linux
	zlib? ( sys-libs/zlib )
	lzma? ( app-arch/lzma )
	zstd? ( app-arch/zstd )
	brotli? ( app-arch/brotli )
	bzip2? ( app-arch/bzip2 )
	xz? ( app-arch/xz-utils )
	dbus? ( sys-apps/dbus )
	qt6? (
		dev-qt/qtbase:6[concurrent,dbus,gui,network,widgets]
		dev-qt/qtdeclarative:6[svg]
	)
	qt5? (
		dev-qt/qtconcurrent:5
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
		dev-qt/qtdeclarative:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtquickcontrols2:5
		dev-qt/qtsvg:5
		dev-qt/qtwidgets:5
	)
"

DEPEND="${RDEPEND}"
BDEPEND="
	gnutls? ( net-libs/gnutls:= )
	!gnutls? ( dev-libs/openssl:= )
	net-misc/curl
	app-arch/libarchive:=
	qt6? ( dev-qt/qttools:6[linguist] )
	!qt6? ( dev-qt/linguist-tools:5 )
"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package gnutls GnuTLS)
		$(cmake_use_find_package qt6 Qt6)
		$(cmake_use_find_package !qt6 Qt5)
		$(cmake_use_find_package zlib ZLIB)
		$(cmake_use_find_package lzma LibLZMA)
		-DENABLE_TELEMETRY=$(usex telemetry)
		-DENABLE_CHECK_VERSION=NO
	)

	cmake_src_configure
}
