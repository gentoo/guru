# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="Python bindings for the Skia Path Ops"
HOMEPAGE="
	https://skia.org/dev/present/pathops
	https://pypi.org/project/skia-pathops/
	https://github.com/fonttools/skia-pathops
"
SRC_URI="$(pypi_sdist_url --no-normalize ${PN} ${PV} .zip)"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

# Until cpdef is removed from skia-pathops, we need cython < 3.0.0
BDEPEND="
	app-arch/unzip
	<dev-python/cython-3[${PYTHON_USEDEP}]
	dev-util/gn
	dev-util/ninja
"

PATCHES=( "${FILESDIR}"/${PN}-0.7.4-no-net.patch )

REPYTEST_DESELECT=(
	tests/pathops_test.py::PathTest::test_transform
	"tests/pathops_test.py::test_path_operation[conic_2_quad-operations3-expected3]"
	"tests/pathops_test.py::test_path_operation[arc_to_quads-operations4-expected4]"
)

distutils_enable_tests pytest
