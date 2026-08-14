# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
LUA_COMPAT=( lua5-{1..4} luajit )
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 lua pypi

DESCRIPTION="Python wrapper around Lua and LuaJIT"
HOMEPAGE="
	https://github.com/scoder/lupa
	https://pypi.org/project/lupa/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
REQUIRED_USE="${LUA_REQUIRED_USE} ${PYTHON_REQUIRED_USE}"

DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-python/cython-3.2.4[${PYTHON_USEDEP}]
	virtual/pkgconfig
"

src_prepare() {
	distutils-r1_src_prepare

	mv lupa/tests . || die
	sed -i "s/lupa.tests/tests/g" tests/test.py || die
}

python_configure_all() {
	DISTUTILS_ARGS=(
		--no-bundle
		--with-cython
	)

	local -a config_items
	_build_config_items() {
		local incdir=$(lua_get_include_dir "${ELUA}")
		local libpath=$(lua_get_shared_lib "${ELUA}")
		local modname="${ELUA/./}"

		config_items+=(
			"dict(extra_objects=['${libpath}'], include_dirs=['${incdir}'], libversion='${modname}')"
		)
	}
	lua_foreach_impl _build_config_items

	local IFS=","
	local configs="[${config_items[*]}]"

	sed -i "s|^configs = get_lua_build_from_arguments()|configs = ${configs}|" setup.py || die
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	EPYTEST_DESELECT=(
		# not a test case
		tests/test.py::TestOverflowMixin
	)

	rm -rf lupa || die
	epytest tests/test.py
}
