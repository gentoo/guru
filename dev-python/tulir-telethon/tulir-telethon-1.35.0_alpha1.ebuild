# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

MY_PV="${PV/_alph/}"
DESCRIPTION="Pure Python 3 MTProto API Telegram client library, for bots too!"
HOMEPAGE="https://github.com/tulir/Telethon/"

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
DEPEND="${RDEPEND}"
