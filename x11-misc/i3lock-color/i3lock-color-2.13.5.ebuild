# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools shell-completion

MY_PV="$(ver_cut 1-2).c.$(ver_cut 3)"

DESCRIPTION="The world's most popular non-default computer lockscreen"
HOMEPAGE="https://github.com/Raymo111/i3lock-color"
SRC_URI="https://github.com/Raymo111/i3lock-color/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

DEPEND="
	dev-libs/libev
	media-libs/fontconfig
	media-libs/libjpeg-turbo:=
	sys-libs/pam
	x11-libs/cairo[X]
	x11-libs/libxcb:=
	x11-libs/libxkbcommon[X]
	x11-libs/xcb-util
	x11-libs/xcb-util-image
	x11-libs/xcb-util-xrm
"
RDEPEND="
	${DEPEND}
	!!x11-misc/i3lock
"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${P}-cleanup-cflags.patch"
	"${FILESDIR}/${P}-disable-automagic.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	newbashcomp i3lock-bash i3lock
	newzshcomp i3lock-zsh _i3lock
}

pkg_postinst() {
	elog "Running i3lock-color:"
	elog "	Simply invoke the 'i3lock' command. To get out of it, enter your password and press enter."
	elog "	More imformation please check https://github.com/Raymo111/i3lock-color#running-i3lock-color"
}
