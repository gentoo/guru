# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="doxygen"
DOCS_DIR="doc"
DOCS_CONFIG_NAME="doxygen_tl.in"
MYPV="github-release-${PV}"
PYTHON_COMPAT=( python3_{8..11} pypy3 )

inherit autotools flag-o-matic fortran-2 python-any-r1 docs

DESCRIPTION="C/C++/Fortran source-to-source compilation aimed at fast prototyping"
HOMEPAGE="https://github.com/bsc-pm/mcxx"
SRC_URI="https://github.com/bsc-pm/mcxx/archive/refs/tags/${MYPV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MYPV}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+analysis array-descriptors bison-reporting examples extrae +mpi +nanox ompss ompss2 +opencl openmp +quad tcl test tl-openmp-gomp tl-openmp-profile vectorization"

CDEPEND="
	dev-db/sqlite
	extrae? ( sys-cluster/extrae )
	mpi? ( virtual/mpi )
	nanox? ( sys-cluster/nanox )
	ompss2? ( sys-cluster/nanos6 )
	tcl? ( sys-cluster/TCL )
"
DEPEND="
	${CDEPEND}
	${PYTHON_DEPS}
	opencl? ( dev-util/opencl-headers )
"
RDEPEND="
	${CDEPEND}
	opencl? ( virtual/opencl )
"
BDEPEND="
	dev-util/gperf
	sys-devel/flex
	virtual/pkgconfig
	virtual/yacc

	test? (
		sys-devel/bc
		app-alternatives/awk
	)
"

RESTRICT="!test? ( test )"
REQUIRED_USE="
	mpi? ( nanox )
	ompss? ( nanox )
	opencl? ( nanox )
	openmp? ( nanox )

	!analysis? ( !vectorization )
"

pkg_setup() {
	fortran-2_pkg_setup
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	# https://github.com/bsc-pm/mcxx/issues/36
	filter-ldflags -Wl,--as-needed

	local myconf=(
		--disable-cray-compilers
		--disable-distcheck-processing
		--disable-ibm-compilers
		--disable-intel-compilers
		--disable-pgi-compilers
		--disable-mic
		--disable-mic-testing
		--disable-nanox-cuda-device
		--disable-nanox-fpga-device

		--enable-bison-regeneration
		--enable-file-regeneration
		--enable-flex-regeneration
		--enable-gperf-regeneration
		--enable-shared

		--without-intel-omp
		--without-nanox-mic
		--without-svml

		$(use_enable analysis)
		$(use_enable array-descriptors gfortran-8-or-greater-array-descriptors )
		$(use_enable bison-reporting)
		$(use_enable examples tl-examples)
		$(use_enable extrae)
		$(use_enable mpi nanox-mpi-device)
		$(use_enable ompss)
		$(use_enable ompss2 ompss-2)
		$(use_enable opencl nanox-opencl-device)
		$(use_enable openmp)
		$(use_enable quad float128)
		$(use_enable quad int128)
		$(use_enable test fortran-tests)
		$(use_enable tl-openmp-gomp)
		$(use_enable tl-openmp-profile)
		$(use_enable vectorization)
	)

	if use extrae; then
		myconf+=( "--with-extrae=${EPREFIX}/usr" )
		myconf+=( "--with-extrae-lib=${EPREFIX}/usr/$(get_libdir)" )
	else
		myconf+=( "--without-extrae" )
	fi
	if use mpi; then
		myconf+=( "--with-mpi=${EPREFIX}/usr" )
	else
		myconf+=( "--without-mpi" )
	fi
	if use nanox; then
		myconf+=( "--with-nanox=${EPREFIX}/usr" )
	else
		myconf+=( "--without-nanox" )
	fi
	if use ompss2; then
		myconf+=( "--with-nanos6=${EPREFIX}/usr" )
		myconf+=( "--with-nanos6-lib=${EPREFIX}/usr/$(get_libdir)" )
	else
		myconf+=( "--without-nanos6" )
	fi
	if use tcl; then
		myconf+=( "--with-tcl=${EPREFIX}/usr" )
		myconf+=( "--with-tcl-lib=${EPREFIX}/usr/$(get_libdir)" )
	else
		myconf+=( "--without-tcl" )
	fi

	use tl-openmp-gomp && myconf+=( "--with-gomp=${EPREFIX}/usr" )

	econf "${myconf[@]}"
}

src_compile() {
	default
	docs_compile
}

src_install() {
	default
	einstalldocs
	find "${D}" -name '*.la' -delete || die
}
