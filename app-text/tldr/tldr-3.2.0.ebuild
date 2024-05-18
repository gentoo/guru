# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1

DESCRIPTION="Python command line client for tldr pages"
HOMEPAGE="https://github.com/tldr-pages/tldr-python-client"
# sdist lacks some files.
SRC_URI="https://github.com/tldr-pages/tldr-python-client/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-python-client-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="man"

RDEPEND="
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/shtab[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	!app-misc/tealdeer
"
BDEPEND="
	man? (
		dev-python/sphinx
		dev-python/sphinx-argparse
	)
"

distutils_enable_tests pytest

src_prepare() {
	use man || sed -i '/data_files/d' setup.py || die
	distutils-r1_src_prepare
}

src_compile() {
	use man && emake -C docs
	distutils-r1_src_compile
}

python_test() {
	local EPYTEST_DESELECT=(
		# tries to access internet
		tests/test_tldr.py::test_error_message
	)
	epytest
}
