# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Math Expression Library"
HOMEPAGE="https://github.com/pcarruscag/MEL"
SRC_URI="https://github.com/pcarruscag/MEL/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="!test? ( test )"

src_compile() {
	tc-export CXX
	if use test; then
		"${CXX}" ${CXXFLAGS} ${LDFLAGS} -fPIE -std=c++11 -I. ./tests.cpp -o ./tests || die
	fi
}

src_install() {
	insinto "/usr/include/${PN}"
	doins mel.hpp definitions.hpp
	dodoc README.md
}

src_test() {
	./tests || die
}
