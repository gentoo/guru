# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

MY_PV="${PV/_alph/}"
DESCRIPTION="Pure Python 3 MTProto API Telegram client library, for bots too!"
HOMEPAGE="https://github.com/tulir/Telethon/"
SRC_URI="https://github.com/tulir/Telethon/archive/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/Telethon-${MY_PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/cryptg[${PYTHON_USEDEP}]
	dev-python/hachoir[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pyaes[${PYTHON_USEDEP}]
	dev-python/PySocks[${PYTHON_USEDEP}]
	dev-python/python-socks[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	tests/readthedocs/quick_references/test_client_reference.py::test_all_methods_present
)
