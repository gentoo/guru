# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN="${PN}-python"
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Network multiplexing and framing protocol for RPC"
HOMEPAGE="https://github.com/uber/tchannel-python"
SRC_URI="https://github.com/uber/${MYPN}/archive/refs/tags/${PV}.tar.gz -> ${P}-gh.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

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
DEPEND="${RDEPEND}"
BDEPEND="
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
