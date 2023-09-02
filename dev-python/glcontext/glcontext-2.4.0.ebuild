# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 virtualx

DESCRIPTION="Modern OpenGL binding for python"
HOMEPAGE="https://github.com/moderngl/glcontext https://pypi.org/project/glcontext"
SRC_URI="https://github.com/moderngl/glcontext/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

BDEPEND="
	x11-libs/libX11
	media-libs/libglvnd[X]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
	 )
"
DEPEND="${BDEPEND}"

distutils_enable_tests pytest
src_test() {
	virtx distutils-r1_src_test
}

python_test() {
	cd "${T}" || die
	epytest "${S}"/tests || die "Tests failed with ${EPYTHON}"
}
