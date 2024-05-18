# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_PN="notion-sdk-py"
DESCRIPTION="Python client for the official Notion API"
HOMEPAGE="
	https://pypi.org/project/notion-client/
	https://github.com/ramnes/notion-sdk-py
"
SRC_URI="https://github.com/ramnes/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/httpx[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-vcr[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	distutils-r1_python_prepare_all
	rm setup.cfg || die
}

python_test() {
	epytest -o "asyncio_mode=auto"
}
