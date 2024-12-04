# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

HASH="fbc534be62f8c785db989f8ae7526edf6d0dc306"
DESCRIPTION="Fast OpenGL Mathematics (GLM) for Python"
HOMEPAGE="https://github.com/Zuzu-Typ/PyGLM https://pypi.org/project/PyGLM"
SRC_URI="
	https://github.com/Zuzu-Typ/PyGLM/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/Zuzu-Typ/glm/archive/${HASH}.tar.gz -> ${P}-glm.gh.tar.gz
"
S="${WORKDIR}/PyGLM-${PV}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/glm
	test? ( dev-python/numpy[${PYTHON_USEDEP}] )
"

EPYTEST_DESELECT=(
	# Tests fails, see https://github.com/Zuzu-Typ/PyGLM/issues/227
	test/PyGLM_test.py::test_findMSB
	test/PyGLM_test.py::test_bitCount
)
distutils_enable_tests pytest

src_prepare() {
	default
	mv "${WORKDIR}/glm-${HASH}"/* -t "${S}/glm" || die "Could not move the glm source"
}
