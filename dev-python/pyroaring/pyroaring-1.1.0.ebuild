# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 flag-o-matic

DESCRIPTION="Python wrapper for the C library CRoaring"
HOMEPAGE="https://github.com/Ezibenroc/PyRoaringBitMap"
# tests not included in pypi tarballs
SRC_URI="
	https://github.com/Ezibenroc/PyRoaringBitMap/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
"

S="${WORKDIR}/PyRoaringBitMap-${PV}"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"

DEPEND="
	dev-libs/croaring
"

RDEPEND="${DEPEND}
"

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	virtual/pkgconfig
	test? ( dev-python/hypothesis[${PYTHON_USEDEP}] )
"

PATCHES=(
	"${FILESDIR}"/${P}-Link-against-system-CRoaring-rather-than-vendor-copy.patch
)

EPYTEST_PLUGINS=(
)

distutils_enable_tests pytest

src_prepare() {
	# make sure we are not bundling croaring
	rm ${PN}/roaring.{c,h} || die

	distutils-r1_src_prepare
}

src_configure() {
	# fatal error: roaring.h: No such file or directory
	append-cppflags $(pkg-config --cflags roaring)

	distutils-r1_src_configure
}

python_test() {
	epytest test.py
}
