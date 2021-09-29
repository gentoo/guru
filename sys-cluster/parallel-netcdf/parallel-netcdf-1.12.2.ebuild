# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_NEEDED=fortran
MYP="pnetcdf-${PV}"

inherit fortran-2

DESCRIPTION="Parallel extension to netCDF"
HOMEPAGE="
	https://parallel-netcdf.github.io
	http://cucis.ece.northwestern.edu/projects/PnetCDF
	http://www-unix.mcs.anl.gov/parallel-netcdf
"
SRC_URI="http://cucis.ece.northwestern.edu/projects/PnetCDF/Release/${MYP}.tar.gz"
S="${WORKDIR}/${MYP}"

LICENSE="UCAR-Unidata"
SLOT="0"
KEYWORDS="~amd64"
IUSE="burst-buffering +cxx debug doc +erange-fill +file-sync +fortran netcdf
null-byte-header-padding +relax-coord-bound subfiling threadsafe"

RDEPEND="
	netcdf? ( sci-libs/netcdf[mpi] )
	virtual/mpi
"
#	adios? ( sys-cluster/adios )
DEPEND="${RDEPEND}"
BDEPEND="doc? ( app-doc/doxygen )"

pkg_setup() {
	fortran-2_pkg_setup
}

src_configure() {
	export MPIF77=/usr/bin/mpif77
	export MPIF90=/usr/bin/mpif90

	local myconf=(
		--enable-shared
		--with-mpi="${EPREFIX}/usr"

		$(use_enable burst-buffering)
		$(use_enable cxx)
		$(use_enable debug)
		$(use_enable doc doxygen)
		$(use_enable erange-fill)
		$(use_enable file-sync)
		$(use_enable fortran)
		$(use_enable netcdf netcdf4)
		$(use_enable null-byte-header-padding)
		$(use_enable relax-coord-bound)
		$(use_enable subfiling)
		$(use_enable threadsafe thread-safe)
	)
#		$(use_enable adios)
#	if use adios; then
#		myconf+=( "--with-adios=${EPREFIX}/usr" )
#	else
#		myconf+=( "--without-adios" )
#	fi
	if use netcdf; then
		myconf+=( "--with-netcdf4=${EPREFIX}/usr" )
	else
		myconf+=( "--without-netcdf4" )
	fi

	econf "${myconf[@]}"
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}
