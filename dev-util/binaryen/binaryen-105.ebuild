# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 pypy3 )

inherit cmake python-any-r1

DESCRIPTION="Compiler and toolchain infrastructure library for WebAssembly"
HOMEPAGE="https://github.com/WebAssembly/binaryen"
SRC_URI="https://github.com/WebAssembly/binaryen/archive/version_${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/binaryen-version_${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="
	test? (
		${PYTHON_DEPS}
		$(python_gen_any_dep '>=dev-python/filecheck-0.0.17[${PYTHON_USEDEP}]')
		$(python_gen_any_dep 'dev-python/lit[${PYTHON_USEDEP}]')
	)
"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_STATIC_LIB=OFF
		-DENABLE_WERROR=OFF
	)
	cmake_src_configure
}

src_test() {
	LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${BUILD_DIR}/lib" "${EPYTHON}" check.py --binaryen-bin="${BUILD_DIR}/bin" || die
}
