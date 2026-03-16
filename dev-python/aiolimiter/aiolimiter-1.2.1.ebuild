# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="An efficient implementation of a rate limiter for asyncio"
HOMEPAGE="
	https://github.com/mjpieters/aiolimiter
	https://pypi.org/project/aiolimiter/
"
SRC_URI="https://github.com/mjpieters/aiolimiter/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? ( dev-python/toml[${PYTHON_USEDEP}] )
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

src_prepare() {
	sed -i 's/"session"/session/' tox.ini || die

	distutils-r1_src_prepare
}

python_test() {
	epytest -o addopts=
}

src_install() {
	distutils-r1_src_install

	dodoc LICENSE.txt
}
