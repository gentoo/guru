# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MYP="${P/_p/.post}"
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Python bindings for the Skia Path Ops"
HOMEPAGE="
	https://github.com/fonttools/skia-pathops
	https://skia.org/dev/present/pathops
"
SRC_URI="mirror://pypi/${MYP:0:1}/${PN}/${MYP}.zip"
S="${WORKDIR}/${MYP}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/skia
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

python_test() {
	# assert <pathops.Path object at 0x7fe53e76cc00: 1 contours> == <pathops.Path object at 0x7fe53e76c2a0: 1 contours>
	epytest --deselect tests/pathops_test.py::PathTest::test_transform
}
