# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

DESCRIPTION="Date parsing library designed to parse dates from HTML pages"
HOMEPAGE="https://github.com/scrapinghub/dateparser"
SRC_URI="https://github.com/scrapinghub/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64"

# Requires access to the internet
RESTRICT="test"

DEPEND="test? (
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/parameterized[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]
	dev-python/ordered-set[${PYTHON_USEDEP}]
)"

RDEPEND="
	dev-python/convertdate[${PYTHON_USEDEP}]
	dev-python/hijri-converter[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
distutils_enable_sphinx docs
