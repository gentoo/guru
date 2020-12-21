# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Improved i3lock with color customization"
HOMEPAGE="https://github.com/Raymo111/i3lock-color"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="i3lock-color"
SLOT="0"

DEPEND="
	dev-libs/libev
	media-libs/fontconfig:=
	media-libs/libjpeg-turbo
	sys-libs/pam
	x11-libs/cairo
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/xcb-util-image
	x11-libs/xcb-util-xrm
	x11-libs/libxkbcommon
"
RDEPEND="
	${DEPEND}
	!!x11-misc/i3lock
"
BDEPEND="virtual/pkgconfig"

src_configure() {
	autoreconf -fiv
	default
}

pkg_postinst() {
	elog "Running i3lock-color:"
	elog "Simply invoke the 'i3lock' command. To get out of it, enter your password and press enter."
	elog "More imformation please check https://github.com/Raymo111/i3lock-color#running-i3lock-color"
}
