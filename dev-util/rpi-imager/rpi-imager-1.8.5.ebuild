# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature xdg

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
IUSE="gnutls qt6 telemetry"

RDEPEND="
	app-arch/libarchive:=
	app-arch/xz-utils
	net-misc/curl
	sys-apps/util-linux
	sys-libs/zlib
	gnutls? ( net-libs/gnutls:= )
	!gnutls? ( dev-libs/openssl:= )
	qt6? (
		dev-qt/qtbase:6[concurrent,dbus,gui,network,widgets]
		dev-qt/qtdeclarative:6[svg]
	)
	!qt6? (
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
	qt6? ( dev-qt/qttools:6[linguist] )
	!qt6? ( dev-qt/linguist-tools:5 )
"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package gnutls GnuTLS)
		$(cmake_use_find_package !qt6 Qt5)
		-DENABLE_TELEMETRY=$(usex telemetry)
		-DENABLE_CHECK_VERSION=NO
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "running as a non-root user" sys-fs/udisks
}
