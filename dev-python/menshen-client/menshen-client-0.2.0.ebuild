# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=uv-build

inherit distutils-r1

DESCRIPTION="API client for Menshen, the OAuth 2.0 token exchange server"
HOMEPAGE="
	https://github.com/suitenumerique/menshen
	https://pypi.org/project/menshen-client/
"
SRC_URI="https://github.com/suitenumerique/menshen/archive/refs/tags/v${PV}-client.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/menshen-${PV}-client/src/client"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

RDEPEND="
	>=dev-python/requests-2.32.3[${PYTHON_USEDEP}]
"
