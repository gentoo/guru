# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="xml(+)"
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature pypi

DESCRIPTION="AutoRest swagger generator Python client runtime"
HOMEPAGE="https://github.com/Azure/msrest-for-python"
SRC_URI="$(pypi_sdist_url ${PN} ${PV} .zip)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="
	dev-python/azure-core[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/isodate[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
"
BDEPEND="
	app-arch/unzip
	test? (
		dev-python/aiodns[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/httpretty[${PYTHON_USEDEP}]
		dev-python/oauthlib[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "async support" "dev-python/aiodns dev-python/aiohttp"
}
