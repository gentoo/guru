# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Network multiplexing and framing protocol for RPC"
HOMEPAGE="https://github.com/uber/tchannel"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/crcmod-1[${PYTHON_USEDEP}]
	>=dev-python/opentracing-2[${PYTHON_USEDEP}]
	>=dev-python/opentracing_instrumentation-3[${PYTHON_USEDEP}]
	>=dev-python/thriftrw-0.4[${PYTHON_USEDEP}]
	>=dev-python/threadloop-1[${PYTHON_USEDEP}]
	>=www-servers/tornado-4.3[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hypothesis-1.14[${PYTHON_USEDEP}]
		dev-python/ipdb[${PYTHON_USEDEP}]
		>=dev-python/jaeger-client-4[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pygal[${PYTHON_USEDEP}]
		>=dev-python/pytest-benchmark-3[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
		dev-python/pytest-tornado[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		>=dev-python/wrapt-1.10[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
