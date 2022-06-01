# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Asynchronous SMTP client for use with asyncio"
HOMEPAGE="https://pypi.org/project/aiosmtplib/ https://github.com/cole/aiosmtplib"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	test? (
		dev-python/aiosmtpd[${PYTHON_USEDEP}]
		dev-python/atpublic[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=( tests/test_connect.py::test_connect_via_socket_path )

distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/sphinx-autodoc-typehints

python_test() {
	epytest --event-loop=asyncio
}
