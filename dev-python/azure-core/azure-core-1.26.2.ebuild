# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature

DESCRIPTION="Microsoft Azure Core Library for Python"
HOMEPAGE="
	https://pypi.org/project/azure-core/
	https://github.com/Azure/azure-sdk-for-python
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="app-arch/unzip"
# TODO: package azure-sdk-tools
#BDEPEND="
#	app-arch/unzip
#	test? (
#		dev-python/aiohttp[${PYTHON_USEDEP}]
#		dev-python/azure-sdk-tools[${PYTHON_USEDEP}]
#		dev-python/flask[${PYTHON_USEDEP}]
#		dev-python/msrest[${PYTHON_USEDEP}]
#		dev-python/pytest-trio[${PYTHON_USEDEP}]
#		dev-python/requests[${PYTHON_USEDEP}]
#	)
#"

DOCS=( {CHANGELOG,CLIENT_LIBRARY_DEVELOPER,README}.md )

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "aio support" dev-python/aiohttp
}
