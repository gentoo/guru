# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1

DESCRIPTION="Parse OPML subscriptions in Python"
HOMEPAGE="
	https://github.com/kurtmckee/listparser/
	https://pypi.org/project/listparser/
"
SRC_URI="
	https://github.com/kurtmckee/listparser/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.rst CHANGELOG.rst )

# These are technically optional, but don't really see a need to exclude
# them here
RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
