# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake fortran-2

DESCRIPTION="Mathematical software for solving large-scale dense linear systems"
HOMEPAGE="https://github.com/liuyangzhuan/ButterflyPACK"
SRC_URI="https://github.com/liuyangzhuan/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"
IUSE="arpack magma"

RDEPEND="
	sci-libs/scalapack
	virtual/blas
	virtual/lapack
	virtual/mpi

	arpack? ( sci-libs/arpack )
	magma? ( sci-libs/magma )
"
DEPEND="${RDEPEND}"

DOCS=( README.md CHANGELOG )

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON

		-DTPL_ARPACK_LIBRARIES=$(usex arpack)
		-DTPL_MAGMA_LIBRARIES=$(usex magma)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	insinto "/usr/share/octave/site/m/${PN}"
	doins -r MATLAB/*
}
