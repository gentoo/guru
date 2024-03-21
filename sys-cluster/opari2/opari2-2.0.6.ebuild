# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools toolchain-funcs

DESCRIPTION="OpenMP Pragma And Region Instrumentor"
HOMEPAGE="https://www.vi-hps.org/projects/score-p"
SRC_URI="https://perftools.pages.jsc.fz-juelich.de/cicd/${PN}/tags/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="${RDEPEND}"

src_prepare() {
	tc-export CC CXX AR F77 FC CPP
	export CXXCPP="${CPP}"
	export CC_FOR_BUILD="${CC}"
	export CXX_FOR_BUILD="${CXX}"
	export FC_FOR_BUILD="${FC}"
	export F77_FOR_BUILD="${F77}"
	export CFLAGS_FOR_BUILD="${CFLAGS}"
	export CXXFLAGS_FOR_BUILD="${CXXFLAGS}"
	export FFLAGS_FOR_BUILD="${FFLAGS}"
	export FCFLAGS_FOR_BUILD="${FCFLAGS}"
	export LDFLAGS_FOR_BUILD="${LDFLAGS}"
	export CPPFLAGS_FOR_BUILD="${CPPFLAGS}"

	default
	eautoreconf
}

src_install() {
	default
	dodoc OPEN_ISSUES README
	find "${ED}" -name '*.la' -delete || die
	find "${ED}" -name '*.a' -delete || die
}
