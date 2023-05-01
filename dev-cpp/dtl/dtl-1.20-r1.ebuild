# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit python-any-r1 scons-utils toolchain-funcs

DESCRIPTION="diff template library written by C++"
HOMEPAGE="https://github.com/cubicdaiya/dtl"
SRC_URI="https://github.com/cubicdaiya/dtl/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="examples test"

DEPEND="test? ( dev-cpp/gtest )"

RESTRICT="!test? ( test )"
PATCHES=( "${FILESDIR}/${PN}-1.19_p20210531-do-not-append-O2.patch" )

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
	insinto /usr/include/dtl
	doins "${T}/dtl/include"/*
	if use examples; then
		pushd examples || die
		rm SConstruct *.o *.cpp *.hpp || die
		exeinto /usr/libexec/dtl/examples
		doexe *
	fi
}

src_test() {
	pushd test || die
	escons check
}
