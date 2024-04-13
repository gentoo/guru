# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="python-gnuplot"
MYPV="$(ver_cut 1-2)"
MYP="${PN}-${MYPV}"
PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A python wrapper for Gnuplot"
HOMEPAGE="https://gnuplot-py.sourceforge.net/"
SRC_URI="
	mirror://sourceforge/${PN}/${MYP}.tar.gz
	mirror://debian/pool/main/p/${MYPN}/${MYPN}_${PV//_p/-}.debian.tar.xz
"
S="${WORKDIR}/${MYP}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="
	${DEPEND}
	sci-visualization/gnuplot
"

DOCS="ANNOUNCE.txt CREDITS.txt FAQ.txt NEWS.txt TODO.txt"
PATCHES=(
	"${WORKDIR}/debian/patches/00-python3-port.patch"
	"${WORKDIR}/debian/patches/fix-privacy-breach.patch"
	"${WORKDIR}/debian/patches/00-remove-version-import.patch"
	"${WORKDIR}/debian/patches/fix-python-name.patch"
	"${WORKDIR}/debian/patches/fix-malfuction-mouse-keys.patch"
	"${WORKDIR}/debian/patches/fix-string-exceptions.patch"
)

python_install_all() {
	HTML_DOCS=( doc/Gnuplot/*.html )
	einstalldocs
}
