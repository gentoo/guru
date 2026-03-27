# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Client protocol specification for agent interactions"
HOMEPAGE="
	https://github.com/agentclientprotocol/python-sdk
	https://pypi.org/project/agent-client-protocol/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
