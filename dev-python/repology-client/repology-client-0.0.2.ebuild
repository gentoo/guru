# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Asynchronous wrapper for Repology API"
HOMEPAGE="
	https://repology-client.sysrq.in/
	https://pypi.org/project/repology-client/
"

LICENSE="CC-BY-SA-3.0 EUPL-1.2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	<dev-python/aiohttp-4[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2[${PYTHON_USEDEP}]
	<dev-python/pydantic-3[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-recording[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-aiohttp-theme \
	dev-python/sphinx-prompt
