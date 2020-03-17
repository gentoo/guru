# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="${PV//_p1/.c.1}"

DESCRIPTION="Improved i3lock with color customization"
HOMEPAGE="https://github.com/Raymo111/i3lock-color"
SRC_URI="https://github.com/Raymo111/i3lock-color/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"

LICENSE="i3lock-color"
SLOT="0"

RDEPEND="
	x11-libs/cairo
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/xcb-util-image
	x11-libs/xcb-util-xrm
	x11-libs/libxkbcommon
	sys-libs/pam
	dev-libs/libev
	media-libs/fontconfig:=
	media-libs/libjpeg-turbo
"

DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

S="${WORKDIR}/${PN}-${MY_PV}"

src_configure() {
	autoreconf -fiv
	econf
}

pkg_postinst() {
	elog "Running i3lock-color:"
	elog "	Simply invoke the 'i3lock' command. To get out of it, enter your password and press enter."
	elog "	More imformation please check https://github.com/Raymo111/i3lock-color#running-i3lock-color"
}
