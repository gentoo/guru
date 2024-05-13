# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

COMMIT="f7a8dbb3f81be81224368970054fd33d2814c9d7"

DESCRIPTION="Client library for ActivityWatch"
HOMEPAGE="https://activitywatch.net"
SRC_URI="https://github.com/ActivityWatch/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

# Test tries to connect to aw-server
RESTRICT="test"

RDEPEND="
	app-misc/aw-core[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/persist-queue[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
