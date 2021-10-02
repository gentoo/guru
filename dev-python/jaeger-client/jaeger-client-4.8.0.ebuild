# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Jaeger Bindings for Python OpenTracing API"
HOMEPAGE="
	https://github.com/jaegertracing/jaeger-client-python
	https://pypi.org/project/jaeger-client
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/threadloop-1[${PYTHON_USEDEP}]
	dev-python/thrift[${PYTHON_USEDEP}]
	>=www-servers/tornado-4.3[${PYTHON_USEDEP}]
	>=dev-python/opentracing-2.1[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pycurl[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
		dev-python/pytest-tornado[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/pytest-localserver[${PYTHON_USEDEP}]
		>=dev-python/tchannel-2.1.0[${PYTHON_USEDEP}]
		>=dev-python/opentracing_instrumentation-3[${PYTHON_USEDEP}]
		>=dev-python/prometheus_client-0.11.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
