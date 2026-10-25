# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Clean, filter and sample URLs to optimize data collection"
HOMEPAGE="https://github.com/adbar/courlan"
SRC_URI="https://github.com/adbar/courlan/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/babel[${PYTHON_USEDEP}]
	dev-python/tld[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest-httpserver )
distutils_enable_tests pytest
