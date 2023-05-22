# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_11 )
inherit distutils-r1

DESCRIPTION="gRPC typing stubs for Python"
HOMEPAGE="
	https://pypi.org/project/grpc-stubs/
	https://github.com/shabbyrobe/grpc-stubs/
"

SRC_URI="https://github.com/shabbyrobe/grpc-stubs/archive/refs/tags/${PV}.tar.gz
	-> ${P}.gh.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/grpcio[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		  dev-python/mypy[${PYTHON_USEDEP}]
		  dev-python/pytest-mypy-plugins[${PYTHON_USEDEP}]
		  dev-python/types-protobuf[${PYTHON_USEDEP}]
		  )
"

distutils_enable_tests pytest

python_test() {
	epytest --mypy-ini-file=setup.cfg
}
