# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Scalable Performance Analysis of Large-Scale Applications"
HOMEPAGE="https://www.scalasca.org/scalasca/software/scalasca-2.x/download.html"
SRC_URI="http://apps.fz-juelich.de/${PN}/releases/${PN}/${PV}/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+openmp"

RDEPEND="
	dev-libs/cubelib
	dev-libs/cubew
	gui-libs/cubegui
	sys-cluster/otf2
	sys-cluster/scorep
	sys-libs/binutils-libs
	sys-libs/zlib
	virtual/mpi
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/bison
	sys-devel/flex
"

src_prepare() {
	rm -r vendor || die
	default
}

src_configure() {
	tc-export CC CXX FC F77 CPP

	export MPICC=/usr/bin/mpicc
	export MPICXX=/usr/bin/mpicxx
	export MPIF77=/usr/bin/mpif77
	export MPIFC=/usr/bin/mpifc

	export MPI_CFLAGS="${CFLAGS}"
	export MPI_CXXFLAGS="${CXXFLAGS}"
	export MPI_CPPFLAGS="${CPPFLAGS}"
	export MPI_F77LAGS="${F77FLAGS}"
	export MPI_FCLAGS="${FCFLAGS}"
	export MPI_LDFLAGS="${LDFLAGS}"

	local myconf=(
		--disable-platform-mic
		--disable-static
		--enable-shared
		--with-cubew="${EPREFIX}/usr"
		--with-libz="${EPREFIX}/usr"
		--with-otf2="${EPREFIX}/usr"
		$(use_enable openmp)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	mkdir -p "${ED}/usr/share/doc/${PF}/html" || die
	mv "${ED}/usr/share/doc/${PF}/manual/html" "${ED}/usr/share/doc/${PF}/html/manual" || die
	mv "${ED}/usr/share/doc/${PF}/patterns" "${ED}/usr/share/doc/${PF}/html/patterns" || die
	docompress -x "/usr/share/doc/${PF}/html"

	find "${ED}" -name '*.la' -delete || die
}
