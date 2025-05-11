# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
inherit distutils-r1 pypi

DESCRIPTION="Python bindings to Zstandard (zstd) compression library"
HOMEPAGE="
	https://github.com/Rogdham/pyzstd
	https://pypi.org/project/pyzstd/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-arch/zstd:=
	$(python_gen_cond_dep '
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	' 3.{11,12})
"
DEPEND="${RDEPEND}"

distutils_enable_tests unittest

src_prepare() {
	# we don't need the custom build backend
	sed -i 's/pyzstd_pep517/setuptools.build_meta/' pyproject.toml || die
	sed -i "s/'-g0', '-flto'//" setup.py || die
	distutils-r1_src_prepare
}

python_configure_all() {
	DISTUTILS_ARGS=( --dynamic-link-zstd )
}

python_test() {
	eunittest tests
}
