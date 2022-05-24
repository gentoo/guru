# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION='Open Multiprocessing Differentiation Library'
HOMEPAGE="
	https://github.com/SciCompKL/OpDiLib
	https://www.scicomp.uni-kl.de/software/opdi/
"
SRC_URI="https://github.com/SciCompKL/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE='GPL-3'
IUSE="examples"
SLOT="0"

DEPEND="examples? ( sci-libs/CoDiPack )"
RDEPEND="${DEPEND}"

src_compile() {
	if use examples; then
		tc-export CXX
		"${CXX}" -I/usr/include/codi -I./include --std=c++11 -fopenmp -o macroexample macroexample.cpp || die
		"${CXX}" -I/usr/include/codi -I./include --std=c++11 -fopenmp -o omptexample omptexample.cpp || die
	fi
	return
}

src_install() {
	dodoc README.md
	doheader -r include/*
	insinto "/usr/share/${PN}"
	doins -r syntax
	exeinto "/usr/libexec/${PN}/examples"
	use examples && doexe {macro,ompt}example
}
