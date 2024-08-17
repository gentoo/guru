# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Hunt down social media accounts by username across social networks"
HOMEPAGE="https://sherlockproject.xyz/"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sherlock-project/sherlock.git"
else
	SRC_URI="https://github.com/sherlock-project/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
RESTRICT="!test? ( test )"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/certifi-2019.6.16[${PYTHON_USEDEP}]
		>=dev-python/colorama-0.4.1[${PYTHON_USEDEP}]
		>=dev-python/PySocks-1.7.0[${PYTHON_USEDEP}]
		>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
		>=dev-python/requests-futures-1.00.0[${PYTHON_USEDEP}]
		>=dev-python/pandas-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/openpyxl-3.0.10.0.0[${PYTHON_USEDEP}]
	')
"
BDEPEND="test? ( $(python_gen_cond_dep 'dev-python/jsonschema[${PYTHON_USEDEP}]') )"

distutils_enable_tests pytest
distutils_enable_sphinx docs

python_test() {
	epytest -m 'not online'
}
