# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_NEEDED=fortran
MYP="pnetcdf-${PV}"

inherit autotools fortran-2

DESCRIPTION="Parallel extension to netCDF"
HOMEPAGE="
	https://parallel-netcdf.github.io
	https://trac.mcs.anl.gov/projects/parallel-netcdf
"
SRC_URI="https://parallel-netcdf.github.io/Release/${MYP}.tar.gz"
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
BDEPEND="
	doc? (
		app-text/doxygen
		dev-texlive/texlive-latex
	)
"

RESTRICT="test" # tests require MPI set up
PATCHES=(
	"${FILESDIR}/${P}-no-DESTDIR-for-info-clarity.patch"
	"${FILESDIR}/${P}-respect-flags.patch"
)

pkg_setup() {
	fortran-2_pkg_setup
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	export MPIF77=/usr/bin/mpif77
	export MPIF90=/usr/bin/mpif90
	export VARTEXFONTS="${T}/fonts"

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

src_install() {
	default
	dodoc doc/README.{ADIOS.md,NetCDF4.md,burst_buffering,consistency,large_files} doc/pbs.script
	use doc && dodoc doc/pnetcdf-api/pnetcdf-api.pdf
	find "${ED}" -name '*.la' -delete || die
}
