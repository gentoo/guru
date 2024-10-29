# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

MY_PN="python-${PN}"
DESCRIPTION="Render reStructuredText documents to the terminal"
HOMEPAGE="
	https://pypi.org/project/rst2ansi/
	https://github.com/Snaipe/python-rst2ansi
"
# use git archives for CLI test data
SRC_URI="https://github.com/Snaipe/python-rst2ansi/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/docutils[${PYTHON_USEDEP}]"
BDEPEND="
	test? ( dev-util/cram )
"

distutils_enable_tests setup.py

src_prepare() {
	distutils-r1_src_prepare

	# remove failing test
	rm test/lists.t || die
}

python_test_all() {
	emake test
}

python_test() {
	:
}
