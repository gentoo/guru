# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )  # doesn't build with pypy3
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="An asyncio PostgreSQL driver"
HOMEPAGE="
	https://pypi.org/project/asyncpg/
	https://github.com/MagicStack/asyncpg
"

LICENSE="Apache-2.0 PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kerberos"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/async-timeout-4.0.3[${PYTHON_USEDEP}]
	' python3_10)
	kerberos? ( dev-python/gssapi[${PYTHON_USEDEP}] )
"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		dev-db/postgresql[kerberos?,server,ssl]
		dev-python/distro[${PYTHON_USEDEP}]
		dev-python/uvloop[${PYTHON_USEDEP}]
		kerberos? (
			app-crypt/mit-krb5
			dev-python/k5test[${PYTHON_USEDEP}]
		)
	)
"

PATCHES=(
	"${FILESDIR}"/${PN}-0.30.0-cflags.patch
)

EPYTEST_IGNORE=(
	# checks versions from env variables
	"${S}"/tests/test__environment.py
	# runs flake8 (???)
	"${S}"/tests/test__sourcecode.py
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

python_prepare_all() {
	# bug #926720
	cat <<-EOF >> setup.cfg || die
		[build_ext]
		cython_always=True
		cython_annotate=False
		cython_directives=
	EOF

	# remove pre-generated Cython sources
	rm asyncpg/{pgproto/pgproto,protocol/protocol}.c || die

	distutils-r1_python_prepare_all
}

python_configure_all() {
	use debug && \
		export ASYNCPG_DEBUG=1

	use kerberos || \
		EPYTEST_DESELECT+=( tests/test_connect.py::TestGssAuthentication )
}

python_test() {
	cd "${T}" || die
	for opt in "" "1"; do
		einfo "  testing with USE_UVLOOP='${opt}'"
		USE_UVLOOP="${opt}" epytest "${S}"/tests
	done
}
