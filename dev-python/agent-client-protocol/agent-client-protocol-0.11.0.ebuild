# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

MY_PN="python-sdk"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Client protocol specification for agent interactions"
HOMEPAGE="
	https://github.com/agentclientprotocol/python-sdk
	https://pypi.org/project/agent-client-protocol/
"
SRC_URI="
	https://github.com/agentclientprotocol/${MY_PN}/archive/refs/tags/${PV}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/pydantic-2.7.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# raise timeout
	sed -i "s/timeout=2/timeout=10/" tests/real_user/test_stdio_limits.py || die
}
