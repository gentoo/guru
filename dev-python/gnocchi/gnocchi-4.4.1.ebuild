# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="OpenTracing API for Python"
HOMEPAGE="
	https://gnocchi.osci.io
	https://github.com/gnocchixyz/gnocchi
	https://pypi.org/project/gnocchi
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/numpy-1.9.0[${PYTHON_USEDEP}]
	dev-python/iso8601[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-3.22.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-policy-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-middleware-3.22.0[${PYTHON_USEDEP}]
	dev-python/pytimeparse[${PYTHON_USEDEP}]
	>=dev-python/pecan-0.9[${PYTHON_USEDEP}]
	dev-python/jsonpatch[${PYTHON_USEDEP}]
	>=dev-python/cotyledon-1.5.0[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/stevedore[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
	>=dev-python/voluptuous-0.8.10[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	>=dev-python/tenacity-4.6.0[${PYTHON_USEDEP}]
	>=dev-python/webob-1.4.1[${PYTHON_USEDEP}]
	dev-python/paste[${PYTHON_USEDEP}]
	dev-python/pastedeploy[${PYTHON_USEDEP}]
	dev-python/daiquiri[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/lz4-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/tooz-1.38[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/pifpaf-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/gabbi-1.37.0[${PYTHON_USEDEP}]
		dev-python/fixtures[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/subunit[${PYTHON_USEDEP}]
		dev-python/os-testr[${PYTHON_USEDEP}]
		dev-python/testrepository[${PYTHON_USEDEP}]
		dev-python/testscenarios[${PYTHON_USEDEP}]
		>=dev-python/testresources-0.2.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-0.9.38[${PYTHON_USEDEP}]
		>=dev-python/webtest-2.0.16[${PYTHON_USEDEP}]
		>=dev-python/keystonemiddleware-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/wsgi_intercept-1.4.1[${PYTHON_USEDEP}]
		dev-python/pyxattr[${PYTHON_USEDEP}]
		dev-python/python-swiftclient[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
