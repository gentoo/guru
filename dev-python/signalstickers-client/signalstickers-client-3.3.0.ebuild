# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A Python client for the Signal stickers API"
HOMEPAGE="https://github.com/signalstickers/signalstickers-client"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
# https://github.com/signalstickers/signalstickers-client/issues/22
RESTRICT="test"

distutils_enable_tests pytest

RDEPEND="
	dev-python/anyio[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-httpx[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"
