# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Pure-Python gRPC implementation for asyncio"
HOMEPAGE="https://github.com/vmagamedov/grpclib"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vmagamedov/grpclib"
else
	MY_PV="${PV/_rc/rc}"
	S="${WORKDIR}/${PN}-${MY_PV}"
	SRC_URI="https://github.com/vmagamedov/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"

RDEPEND="
	>=dev-python/h2-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/hpack-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/hyperframe-6.0.1[${PYTHON_USEDEP}]
	>=dev-python/multidict-6.0.2[${PYTHON_USEDEP}]
	>=dev-python/grpcio-tools-1.43.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/async-timeout[${PYTHON_USEDEP}]
		dev-python/googleapis-common-protos[${PYTHON_USEDEP}]
		dev-python/Faker[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	'dev-python/sphinx-rtd-theme'

python_test() {
	[[ ${EPYTHON} == python3.10 ]] && local EPYTEST_DESELECT=(
		# does not work in python3.10 due to the bug in ssl https://bugs.python.org/issue46067
		'tests/test_client_channel.py::test_default_ssl_context'
	)
	epytest
}
