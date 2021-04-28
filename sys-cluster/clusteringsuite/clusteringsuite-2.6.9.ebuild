# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{7,8,9} )
inherit python-any-r1

DESCRIPTION="Expose the main performance trends in applications computation structure"
HOMEPAGE="
	https://tools.bsc.es/cluster-analysis
	https://github.com/bsc-performance-tools/clustering-suite
"
SRC_URI="https://ftp.tools.bsc.es/clusteringsuite/clusteringsuite-${PV}-src.tar.bz2"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc mpi old-pcfparser"
#TODO: muster treedbscan
#TODO: unbundle ANN

#PATCHES=( "${FILESDIR}/respect-flags.patch" )

RDEPEND="
	dev-libs/boost:=
	sci-libs/ann
	mpi? ( virtual/mpi )
"
#	treedbscan? (
#		dev-libs/boost[threads]:=
#		dev-libs/gmp
#		dev-libs/mpfr
#		sci-mathematics/cgal
#		sys-cluster/synapse
#)

DEPEND="
	${RDEPEND}
	${PYTHON_DEPS}
"
BDEPEND="doc? ( app-doc/doxygen )"

src_configure() {

	local myconf=(
		--disable-static
		--disable-static-boost
		--enable-shared
		--with-boost="${EPREFIX}/usr"
		--with-pic

		$(use_enable old-pcfparser)
	)

	if use mpi; then
		myconf+=( "--with-mpi=${EPREFIX}/usr" )
	else
		myconf+=( "--without-mpi" )
	fi
#	if use muster; then
#		myconf+=( "--with-muster=${EPREFIX}/usr" )
#	else
		myconf+=( "--without-muster" )
#	fi
#	if use treedbscan; then
#		myconf+=( "--enable-treedbscan" )
#		myconf+=( "--with-cgal=${EPREFIX}/usr" )
#		myconf+=( "--with-gmp=${EPREFIX}/usr" )
#		myconf+=( "--with-mpfr=${EPREFIX}/usr" )
#		myconf+=( "--with-synapse=${EPREFIX}/usr" )
#	else
		myconf+=( "--without-cgal" )
		myconf+=( "--without-gmp" )
		myconf+=( "--without-mpfr" )
		myconf+=( "--without-synapse" )
#	fi

	econf "${myconf[@]}" || die
}

src_compile() {
	export VARTEXFONTS="${T}/fonts"
	if use doc ; then
		pushd doc || die
		emake build-documentation
		popd
	fi
	default
}

src_install() {
	MAKEOPTS="-j1" DESTDIR="${D}" emake install

	cd doc || die
	dodoc -r *.pdf

	rm "${ED}/usr/share/doc/clusteringsuite_manual.pdf" || die
	mv "${ED}/usr/share/example" "${ED}/usr/share/doc/${PF}/examples" || die
	docompress -x "/usr/share/doc/${PF}/examples"

	find "${ED}" -name '*.la' -delete || die
}
