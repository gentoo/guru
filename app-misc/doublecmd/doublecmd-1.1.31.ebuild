# Copyright 2016-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="Cross Platform file manager"
HOMEPAGE="https://doublecmd.sourceforge.io/ https://github.com/doublecmd/doublecmd"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2+ LGPL-2.1+ LGPL-3 MPL-1.1 Boost-1.0 BZIP2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	!app-misc/doublecmd-bin
	dev-libs/glib:2
	sys-apps/dbus
	x11-libs/libX11
	dev-libs/libqt6pas:=
"

DEPEND="
	${RDEPEND}
	sys-libs/ncurses:=
"

BDEPEND="
	>=dev-lang/lazarus-3.0[qt6]
"

PATCHES=( "${FILESDIR}"/00-lazbuild-command.patch )

# Built with fpc, does not respect anything
QA_FLAGS_IGNORED=".*"
QA_PRESTRIPPED=".*"

src_compile(){
	./build.sh release qt6 || die
}

src_install(){
	./install/linux/install.sh --install-prefix="${D}" || die
	dodoc doc/README.txt doc/changelog.txt
	rm -r "${ED}"/usr/share/doublecmd/doc || die
	dosym -r /usr/share/doc/"${PF}" /usr/share/doublecmd/doc
}
