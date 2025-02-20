# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

HASH="4c6ce1f1f3e8d3888165f2830adcf340922416c155647b12ebac2dcc423e"
DESCRIPTION="Python bindings for the Skia Path Ops"
HOMEPAGE="
	https://skia.org/dev/present/pathops
	https://pypi.org/project/skia-pathops/
	https://github.com/fonttools/skia-pathops
"
SRC_URI="https://files.pythonhosted.org/packages/e5/85/${HASH}/skia_pathops-${PV}.post2.zip"
S="${WORKDIR}/skia_pathops-${PV}.post2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	app-alternatives/ninja
	app-arch/unzip
	dev-python/cython[${PYTHON_USEDEP}]
	dev-build/gn
"

PATCHES=( "${FILESDIR}"/${PN}-0.8.0-no-net.patch )

REPYTEST_DESELECT=(
	tests/pathops_test.py::PathTest::test_transform
	"tests/pathops_test.py::test_path_operation[conic_2_quad-operations3-expected3]"
	"tests/pathops_test.py::test_path_operation[arc_to_quads-operations4-expected4]"
)

distutils_enable_tests pytest
