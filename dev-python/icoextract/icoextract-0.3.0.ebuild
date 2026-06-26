# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature

DESCRIPTION="Icon extractor for Windows executables (.exe/.dll/.mun)"
HOMEPAGE="https://github.com/jlu5/icoextract"
SRC_URI="https://github.com/jlu5/icoextract/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pefile[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-util/mingw64-toolchain
		media-gfx/imagemagick
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_test() {
	emake -C tests
	distutils-r1_src_test
}

pkg_postinst() {
	optfeature "the thumbnailer" dev-python/pillow
}
