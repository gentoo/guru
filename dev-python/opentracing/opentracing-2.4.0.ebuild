# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="OpenTracing API for Python"
HOMEPAGE="
	http://opentracing.io
	https://github.com/opentracing/opentracing-python
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="
	${RDEPEND}
	test? (
		dev-python/doubles[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		dev-python/gevent[${PYTHON_USEDEP}]
		www-servers/tornado[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
