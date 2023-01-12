# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_10 )
inherit distutils-r1

DESCRIPTION="Generate STAT tables for variable fonts from .stylespace files"
HOMEPAGE="https://github.com/daltonmaag/statmake"
SRC_URI="https://github.com/daltonmaag/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/attrs-21.3[${PYTHON_USEDEP}]
		>=dev-python/cattrs-22.1[${PYTHON_USEDEP}]
		>=dev-python/fonttools-4.11[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	test? (
		$(python_gen_cond_dep '
			>=dev-python/ufo2ft-2.7[${PYTHON_USEDEP}]
			>=dev-python/ufoLib2-0.4[${PYTHON_USEDEP}]
		')
	)
"

distutils_enable_tests pytest

python_install() {
	distutils-r1_python_install --skip-build
	python_domodule "src/${PN}"
}

python_test() {
	local -x PYTHONPATH="${S}/src:${PYTHONPATH}"
	epytest
}
