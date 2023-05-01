# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )  # doesn't build with pypy3
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A fast PostgreSQL Database Client Library for Python/asyncio"
HOMEPAGE="https://github.com/MagicStack/asyncpg"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		dev-db/postgresql
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/uvloop[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest

distutils_enable_sphinx docs dev-python/sphinxcontrib-asyncio dev-python/sphinx-rtd-theme

python_test() {
	cd "${T}" || die
	for opt in "" "1"; do
		einfo "  testing with USE_UVLOOP='${opt}'"
		USE_UVLOOP="${opt}" eunittest "${S}"/tests
	done
}
