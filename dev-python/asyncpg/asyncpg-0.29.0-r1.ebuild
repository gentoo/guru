# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )  # doesn't build with pypy3
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="PostgreSQL driver for asyncio"
HOMEPAGE="
	https://pypi.org/project/asyncpg/
	https://github.com/MagicStack/asyncpg
"

LICENSE="Apache-2.0 PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/async-timeout-4.0.3[${PYTHON_USEDEP}]
	' python3_{10..11})
"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		dev-db/postgresql[server]
		dev-python/uvloop[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	# Works fine with >=dev-python/cython-3
	# https://github.com/MagicStack/asyncpg/pull/1101
	"${FILESDIR}"/cython-3.patch
)

EPYTEST_IGNORE=(
	# checks versions from env variables
	"${S}"/tests/test__environment.py
	# runs flake8 (???)
	"${S}"/tests/test__sourcecode.py
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinxcontrib-asyncio \
	dev-python/sphinx-rtd-theme

src_prepare() {
	# remove pre-generated Cython sources
	rm asyncpg/{pgproto/pgproto,protocol/protocol}.c || die

	distutils-r1_src_prepare
}

src_configure() {
	use debug && \
		export ASYNCPG_DEBUG=1

	distutils-r1_src_configure
}

python_test() {
	cd "${T}" || die
	for opt in "" "1"; do
		einfo "  testing with USE_UVLOOP='${opt}'"
		USE_UVLOOP="${opt}" epytest "${S}"/tests
	done
}
