# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MYP="${PN}-v${PV}"

inherit cmake

DESCRIPTION="A minimalistic I/O forwarding server and client library for SIONlib"
HOMEPAGE="https://gitlab.jsc.fz-juelich.de/cstao-public/SIONlib/SIONfwd"
SRC_URI="https://gitlab.jsc.fz-juelich.de/cstao-public/SIONlib/SIONfwd/-/archive/v${PV}/${MYP}.tar.bz2"
S="${WORKDIR}/${MYP}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="virtual/mpi"
DEPEND="${RDEPEND}"

#RESTRICT="!test? ( test )"
RESTRICT="test" #test failures related to MPI

src_configure() {
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
		-DSIONfwd_BUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}

src_test() {
	./test.sh || die
}
