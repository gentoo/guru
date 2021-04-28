# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="melonDS"
MY_P="${MY_PN}-${PV}"

inherit xdg cmake

DESCRIPTION="Nintendo DS emulator, sorta"
HOMEPAGE="http://melonds.kuribo64.net/"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Arisotura/${MY_PN}.git"
else
	SRC_URI="https://github.com/Arisotura/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	app-arch/libarchive
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	media-libs/libepoxy
	media-libs/libsdl2[sound,video]
	net-libs/gnutls
	net-libs/libpcap
	net-libs/libslirp
	net-misc/curl
	x11-libs/cairo
"
RDEPEND="
	${DEPEND}
"

pkg_postinst() {
	xdg_pkg_postinst

	elog "You need the following files in order to run melonDS:"
	elog "- bios7.bin"
	elog "- bios9.bin"
	elog "- firmware.bin"
	elog "- romlist.bin"
	elog "Place them in ~/.config/melonDS"
	elog "Those files can be found somewhere on the Internet ;-)"
}
