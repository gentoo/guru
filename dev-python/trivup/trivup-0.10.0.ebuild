# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Trivially Up a cluster of applications"
HOMEPAGE="
	https://github.com/edenhill/trivup
	https://pypi.org/project/trivup/
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/jwcrypto[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
