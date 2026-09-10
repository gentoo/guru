# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RPM_COMPRESS_TYPE="xz"

inherit rpm xdg

DESCRIPTION="A vehicle monitoring and management platform"
HOMEPAGE="https://www.cmsv7.com"

SRC_URI="
	amd64? (
		https://www.cmsv7.com/cmssoft/CMSV7_LINUX(AMD64)_${PV}_260327.rpm
	)
"

S=${WORKDIR}
QA_PREBUILT="*"

LICENSE="babelstar"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="mirror"

RDEPEND="
	app-arch/rpm
	app-arch/xz-utils
	dev-libs/nspr
	dev-libs/nss
	net-print/cups
	x11-libs/libxkbcommon
	app-accessibility/at-spi2-core
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxkbcommon
	x11-libs/pango
	dev-libs/expat
	dev-libs/glib
	x11-libs/libxcb
"

BDEPEND="
	app-arch/rpm
	app-arch/xz-utils
"

src_unpack() {
	rpm_src_unpack ${A}
}

src_install()
{
	cp -a opt usr "${ED}/" || die "Failed to copy installation files"
}
