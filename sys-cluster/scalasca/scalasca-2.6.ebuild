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
	tc-export CC CXX FC F77 CPP AR

	cat > build-config/common/platforms/platform-backend-user-provided <<-EOF || die
	CC=${CC}
	CXX=${CXX}
	FC=${FC}
	F77=${F77}
	CPP=${CPP}
	CXXCPP=${CPP}
	EOF

	cat > build-config/common/platforms/platform-frontend-user-provided <<-EOF || die
	CC_FOR_BUILD=${CC}
	F77_FOR_BUILD=${F77}
	FC_FOR_BUILD=${FC}
	CXX_FOR_BUILD=${CXX}
	LDFLAGS_FOR_BUILD=${LDFLAGS}
	CFLAGS_FOR_BUILD=${CFLAGS}
	CXXFLAGS_FOR_BUILD=${CXXFLAGS}
	CPPFLAGS_FOR_BUILD=${CPPFLAGS}
	FCFLAGS_FOR_BUILD=${FCFLAGS}
	FFLAGS_FOR_BUILD=${FFLAGS}
	CXXFLAGS_FOR_BUILD_SCORE=${CXXFLAGS}
	EOF

	cat > build-config/common/platforms/platform-mpi-user-provided <<-EOF || die
	MPICC=mpicc
	MPICXX=mpicxx
	MPIF77=mpif77
	MPIFC=mpif90
	MPI_CPPFLAGS=${CPPFLAGS}
	MPI_CFLAGS=${CFLAGS}
	MPI_CXXFLAGS=${CXXFLAGS}
	MPI_FFLAGS=${FFLAGS}
	MPI_FCFLAGS=${FCFLAGS}
	MPI_LDFLAGS=${LDFLAGS}
	EOF

	local myconf=(
		--disable-platform-mic
		--disable-static
		--enable-shared
		--with-cubew="${EPREFIX}/usr"
		--with-custom-compilers
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
