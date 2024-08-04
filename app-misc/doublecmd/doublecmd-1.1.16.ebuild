# Copyright 2016-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="Cross Platform file manager"
HOMEPAGE="https://doublecmd.sourceforge.io/ https://github.com/doublecmd/doublecmd"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2+ LGPL-2.1+ LGPL-3 MPL-1.1 Boost-1.0 BZIP2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qt6"

RDEPEND="
	!app-misc/doublecmd-bin
	dev-libs/glib:2
	sys-apps/dbus
	x11-libs/libX11
	qt6? (
		dev-libs/libqt6pas:=
	)
	!qt6? (
		dev-libs/libqt5pas:=
	)
"

DEPEND="
	${RDEPEND}
	sys-libs/ncurses:=
"

BDEPEND="
	qt6? (
		>=dev-lang/lazarus-3.0[qt6]
	)
	!qt6? (
		>=dev-lang/lazarus-3.0[qt5]
	)
"

PATCHES=( "${FILESDIR}"/${P}-build.patch )

# Built with fpc, does not respect anything
QA_FLAGS_IGNORED=".*"
QA_PRESTRIPPED=".*"

src_compile(){
	./build.sh release $(usex qt6 qt6 qt5) || die
}

src_install(){
	./install/linux/install.sh --install-prefix="${D}" || die
	dodoc doc/README.txt doc/changelog.txt
	rm -r "${ED}"/usr/share/doublecmd/doc || die
	dosym -r /usr/share/doc/"${PF}" /usr/share/doublecmd/doc
}
