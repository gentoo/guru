# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Python Reddit API Wrapper"
HOMEPAGE="https://pypi.org/project/praw/ https://github.com/praw-dev/praw"
SRC_URI="https://github.com/praw-dev/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {AUTHORS,CHANGES,README}.rst SECURITY.md )

RDEPEND="
	<dev-python/prawcore-3[${PYTHON_USEDEP}]
	dev-python/websocket-client[${PYTHON_USEDEP}]
"
BDEPEND="test? (
	dev-python/betamax[${PYTHON_USEDEP}]
	dev-python/betamax-matchers[${PYTHON_USEDEP}]
)"

distutils_enable_sphinx docs dev-python/sphinx_rtd_theme

distutils_enable_tests pytest

python_prepare_all() {
	# disable optional dependencies
	sed "/update_checker/d" -i setup.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	# spams deprecation warnings
	epytest -p no:asyncio
}
