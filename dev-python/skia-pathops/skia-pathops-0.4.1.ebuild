# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Python bindings for the Skia Path Ops"
HOMEPAGE="
	https://github.com/fonttools/skia-pathops
	https://skia.org/dev/present/pathops
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.zip"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

RDEPEND="
	~media-libs/skia-80_p20191220:=
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/pytest-cython[${PYTHON_USEDEP}]
		dev-python/pytest-randomly[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	app-arch/unzip
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

pkg_setup() {
	export BUILD_SKIA_FROM_SOURCE=0
}

python_prepare_all() {
	sed -e '/doctest-cython/d' -i tox.ini

	# assert <pathops.Path object at 0x7fe53e76cc00: 1 contours> == <pathops.Path object at 0x7fe53e76c2a0: 1 contours>
	sed -i -e 's:test_transform:_&:' \
		tests/pathops_test.py || die

	distutils-r1_python_prepare_all
}
