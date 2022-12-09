# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9,10} )
inherit eutils python-any-r1 toolchain-funcs

DESCRIPTION="IceStorm - tools for analyzing and creating bitstreams for Lattice iCE40 FPGAs"
HOMEPAGE="http://www.clifford.at/icestorm/"
LICENSE="ISC"
if [ ${PV} == "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cliffordwolf/icestorm.git"
else
	EGIT_COMMIT=""
	SRC_URI="https://github.com/cliffordwolf/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
fi

SLOT="0"
IUSE="ftdi"

RDEPEND="ftdi? ( dev-embedded/libftdi:= )"
DEPEND="
		${PYTHON_DEPS}
		virtual/pkgconfig
		${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-9999-prefix.patch
	"${FILESDIR}"/${PN}-9999-ftdi-fix.patch )

src_compile() {
	export PREFIX=/usr
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) CFLAGS="$CFLAGS" ICEPROG=$(usex ftdi 1 0)
}

src_install() {
	emake DESTDIR="${D}" ICEPROG=$(usex ftdi 1 0) install
	einstalldocs
}
