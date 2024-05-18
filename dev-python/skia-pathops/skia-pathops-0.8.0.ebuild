# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
inherit distutils-r1 pypi

hash="fa6de52d9cb3a44158431d4cce870e7c2a56cdccedc8fa1262cbf61d4e1e"

DESCRIPTION="Python bindings for the Skia Path Ops"
HOMEPAGE="
	https://skia.org/dev/present/pathops
	https://pypi.org/project/skia-pathops/
	https://github.com/fonttools/skia-pathops
"
SRC_URI="https://files.pythonhosted.org/packages/37/15/${hash}/${P}.post1.zip"
S="${WORKDIR}/${P}.post1"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	app-alternatives/ninja
	app-arch/unzip
	dev-python/cython[${PYTHON_USEDEP}]
	dev-build/gn
"

PATCHES=( "${FILESDIR}"/${PN}-0.7.4-no-net.patch )

REPYTEST_DESELECT=(
	tests/pathops_test.py::PathTest::test_transform
	"tests/pathops_test.py::test_path_operation[conic_2_quad-operations3-expected3]"
	"tests/pathops_test.py::test_path_operation[arc_to_quads-operations4-expected4]"
)

distutils_enable_tests pytest
