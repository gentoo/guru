# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

HASH="2df8c918ffcb4ad847d2571f32a92447ffebe2e9c94d4ea05d9a86f20beb"
DESCRIPTION="Python bindings for the Skia Path Ops"
HOMEPAGE="
	https://skia.org/dev/present/pathops
	https://pypi.org/project/skia-pathops/
	https://github.com/fonttools/skia-pathops
"
SRC_URI="https://files.pythonhosted.org/packages/45/e5/${HASH}/skia_pathops-${PV}.tar.gz"
S="${WORKDIR}/skia_pathops-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	app-alternatives/ninja
	app-arch/unzip
	dev-python/cython[${PYTHON_USEDEP}]
	dev-build/gn
"

PATCHES=( "${FILESDIR}"/${P}-no-net.patch )

REPYTEST_DESELECT=(
	tests/pathops_test.py::PathTest::test_transform
	"tests/pathops_test.py::test_path_operation[conic_2_quad-operations3-expected3]"
	"tests/pathops_test.py::test_path_operation[arc_to_quads-operations4-expected4]"
)

distutils_enable_tests pytest
