# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 optfeature

DESCRIPTION="Better Protobuf / gRPC Support for Python"
HOMEPAGE="https://github.com/danielgtaylor/python-betterproto"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/danielgtaylor/python-betterproto"
else
	MY_PV="${PV/_beta/b}"
	S="${WORKDIR}/python-${PN}-${MY_PV}"
	SRC_URI="https://github.com/danielgtaylor/python-${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-python/grpclib-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/black-19.3[${PYTHON_USEDEP}]
		>=dev-python/isort-5.10.1[${PYTHON_USEDEP}]
		>=dev-python/jinja-3.0.3[${PYTHON_USEDEP}]
		>=dev-python/grpcio-tools-1.40.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-mock-3.1.1[${PYTHON_USEDEP}]
		>=dev-python/pytest-asyncio-0.12.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
	'>=dev-python/sphinx-rtd-theme-0.5.0'

python_test() {
	"${EPYTHON}" -m tests.generate
	epytest
}

pkg_postinst() {
	optfeature "protoc compilation support" "dev-python/black dev-python/isort dev-python/grpcio-tools dev-python/jinja"
}
