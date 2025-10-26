# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature

DESCRIPTION="A pythonic generic language server"
HOMEPAGE="
	https://github.com/openlawlibrary/pygls
	https://pypi.org/project/pygls
"
SRC_URI="https://github.com/openlawlibrary/pygls/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/attrs-24.3.0[${PYTHON_USEDEP}]
	>=dev-python/cattrs-24.3.0[${PYTHON_USEDEP}]
	~dev-python/lsprotocol-2025.0.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		>=dev-python/pytest-7.4.3[${PYTHON_USEDEP}]
		>=dev-python/pytest-asyncio-0.21.0[${PYTHON_USEDEP}]
		>=dev-python/websockets-13.0.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "websockets support" dev-python/websockets
}
