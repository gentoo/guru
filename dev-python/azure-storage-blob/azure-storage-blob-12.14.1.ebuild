# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Microsoft Azure Blob Storage Client Library for Python"
HOMEPAGE="
	https://pypi.org/project/azure-storage-blob/
	https://github.com/Azure/azure-sdk-for-python
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	>=dev-python/azure-core-1.24.2[${PYTHON_USEDEP}]
	<dev-python/azure-core-2.0.0[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/msrest[${PYTHON_USEDEP}]
"
BDEPEND="app-arch/unzip"
# TODO: package azure-sdk-tools (https://github.com/Azure/azure-sdk-for-python/tree/main/tools/azure-sdk-tools)
#BDEPEND="
#	app-arch/unzip
#	test? (
#		dev-python/aiohttp[${PYTHON_USEDEP}]
#		dev-python/azure-sdk-tools[${PYTHON_USEDEP}]
#		dev-python/requests[${PYTHON_USEDEP}]
#	)
#"

DOCS=( {CHANGELOG,README,migration_guide}.md )

distutils_enable_tests pytest
