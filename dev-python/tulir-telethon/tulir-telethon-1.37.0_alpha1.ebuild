# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

MY_PN="Telethon"
MY_PV="${PV/_alph/}"
DESCRIPTION="Full-featured Telegram client library for Python 3"
HOMEPAGE="
	https://pypi.org/project/tulir-telethon/
	https://github.com/tulir/Telethon/
"
SRC_URI="https://github.com/tulir/${MY_PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/cryptg[${PYTHON_USEDEP}]
	dev-python/hachoir[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pyaes[${PYTHON_USEDEP}]
	dev-python/PySocks[${PYTHON_USEDEP}]
	dev-python/python-socks[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]
"
BDEPEND="
	test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}] )
"

EPYTEST_DESELECT=(
	tests/telethon/test_utils.py::test_private_get_extension
)

distutils_enable_tests pytest

python_test() {
	epytest tests/telethon
}
