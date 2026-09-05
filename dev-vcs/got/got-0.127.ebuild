# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Version control system prioritizing ease of use over flexibility"
HOMEPAGE="https://gameoftrees.org/"
SRC_URI="https://gameoftrees.org/releases/portable/${PN}-portable-${PV}.tar.gz"
S="${WORKDIR}/${PN}-portable-${PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cvg"

RDEPEND="
	sys-libs/ncurses:=
	dev-libs/libbsd
	app-crypt/libmd
	sys-apps/util-linux
	virtual/zlib
	dev-libs/libevent
	dev-libs/libretls
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-alternatives/yacc
	virtual/pkgconfig
"

# tests hardcode libexec paths and only pass after a system-wide install
RESTRICT="test"

src_configure() {
	econf $(use_enable cvg)
}

pkg_postinst() {
	elog "gitwrapper requires dev-vcs/git and manual symlink setup."
	elog "See README.portable for details."
}
