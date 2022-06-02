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
SRC_URI="https://github.com/edenhill/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/jwcrypto[${PYTHON_USEDEP}]
	dev-python/python_jwt[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

RESTRICT="test" # tests try to download and install kafka

distutils_enable_tests pytest
