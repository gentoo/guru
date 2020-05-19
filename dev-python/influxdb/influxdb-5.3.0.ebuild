# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Python client for InfluxDB"
HOMEPAGE="https://github.com/influxdata/influxdb-python"
# pypi mirror don't have all required tests files
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-python-${PV}"

RDEPEND="
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
	"

DEPEND="
	${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}]
	)"

distutils_enable_tests nose
distutils_enable_sphinx docs/source dev-python/sphinx_rtd_theme
