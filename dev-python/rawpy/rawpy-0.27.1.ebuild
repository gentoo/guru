# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Python wrapper for LibRaw, RAW image processing"
HOMEPAGE="https://github.com/letmaik/rawpy https://pypi.org/project/rawpy/"
SRC_URI="https://github.com/letmaik/rawpy/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=media-libs/libraw-0.21:="
RDEPEND="${DEPEND}
	dev-python/numpy[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	virtual/pkgconfig
	test? (
		dev-python/imageio[${PYTHON_USEDEP}]
		dev-python/scikit-image[${PYTHON_USEDEP}]
	)"

EPYTEST_PLUGINS=()
EPYTEST_IGNORE=(
	test_mypy.py
	test_stubtest.py
)
distutils_enable_tests pytest

python_configure_all() {
	export RAWPY_USE_SYSTEM_LIBRAW=1
}

python_test() {
	cd test || die
	epytest
}
