# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Twitter scraping & OSINT tool written in Python that doesn't use Twitter's API"
HOMEPAGE="
	https://github.com/twintproject/twint
	https://pypi.org/project/twint
"
SRC_URI="https://github.com/twintproject/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
#tests require network
RESTRICT="test"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/aiohttp-socks[${PYTHON_USEDEP}]
	dev-python/aiodns[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/cchardet[${PYTHON_USEDEP}]
	dev-python/elasticsearch-py[${PYTHON_USEDEP}]
	dev-python/fake-useragent[${PYTHON_USEDEP}]
	dev-python/geopy[${PYTHON_USEDEP}]
	dev-python/googletransx[${PYTHON_USEDEP}]
	>=dev-python/pandas-0.23.0[${PYTHON_USEDEP}]
	dev-python/PySocks[${PYTHON_USEDEP}]
	dev-python/schedule[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

python_test() {
	"${EPYTHON}" test.py -v || die
}
