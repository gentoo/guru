# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Python wrapper for extended filesystem attributes"
HOMEPAGE="
	https://pypi.org/project/xattr/
	https://github.com/xattr/xattr
"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

BDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/cffi-1.16.0[${PYTHON_USEDEP}]
	' 'python*')
	test? ( sys-apps/attr )
"

distutils_enable_tests pytest

python_test() {
	cd "${T}" || die
	epytest "${S}"/tests
}

check_xattr() {
	touch tt || die

	setfattr -n "user.testAttr" -v "attribute value" tt || return 1
	getfattr -n "user.testAttr" tt >/dev/null || return 1

	rm -f tt
	return 0
}

src_test() {
	if ! check_xattr; then
		ewarn "Extended attributes not supported on your filesystem, skipping tests"
		return 0
	fi

	distutils-r1_src_test
}
