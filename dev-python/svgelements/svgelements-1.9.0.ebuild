# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="SVG Parsing for Elements, Paths, and other SVG Objects."
HOMEPAGE="https://github.com/meerk40t/svgelements https://pypi.org/project/svgelements"
SRC_URI="https://github.com/meerk40t/svgelements/archive/refs/tags/${PV}.tar.gz -> v${PV}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
	)
"
DEPEND="${BDEPEND}"

distutils_enable_tests pytest

src_prepare() {
	default
	mv "${S}/test" "${S}_tests"
}

python_test() {
	cd "${T}" || die
	epytest "${S}_tests"
}

pkg_postinst() {
	elog Some other packages could be installed to extend functionnality:
	elog
	elog - dev-python/scipy, to be more precise for arc lenght
	elog - dev-python/pillow, to be able to load images
	elog - dev-python/numpy, to do lightning fast linearization for Shapes
}
