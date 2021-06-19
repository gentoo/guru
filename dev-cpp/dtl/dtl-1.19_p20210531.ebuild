# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="18e674e4a6fdc8c22534a207ff7812ed932a5e61"
PYTHON_COMPAT=( python3_{8..9} pypy3 )

inherit python-any-r1 scons-utils toolchain-funcs

DESCRIPTION="diff template library written by C++"
HOMEPAGE="https://github.com/cubicdaiya/dtl"
SRC_URI="https://github.com/cubicdaiya/dtl/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples test"
RESTRICT="!test? ( test )"

DEPEND="
	test? (
		dev-cpp/gtest
	)
"

PATCHES=( "${FILESDIR}/${P}-do-not-append-O2.patch" )

src_compile() {
	escons CC="$(tc-getCC)"
	if use test; then
		pushd test || die
		escons CC="$(tc-getCC)"
		popd || die
	fi
	if use examples; then
		pushd examples || die
		escons CC="$(tc-getCC)"
		popd || die
	fi
}

src_install() {
	escons prefix="${T}" install
	doheader "${T}/dtl/include"/*
	if use examples; then
		cd examples || die
		rm SConstruct *.o *.cpp *.hpp || die
		exeinto /usr/libexec/dtl/examples
		doexe *
	fi
}

src_test() {
	cd test || die
	escons check
}
