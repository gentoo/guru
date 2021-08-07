# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_NEEDED="fortran"

inherit autotools fortran-2

DESCRIPTION="implementation of the OpenSHMEM specification"
HOMEPAGE="https://github.com/Sandia-OpenSHMEM/SOS"
SRC_URI="https://github.com/Sandia-OpenSHMEM/SOS/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD public-domain mpich2"
SLOT="0"
KEYWORDS="~amd64"
IUSE_OFI_MR="
	ofi-mr-basic
	+ofi-mr-scalable
	ofi-mr-rma-event
"
IUSE_TOTAL_DATA_ORDERING="
	total-data-ordering-always
	+total-data-ordering-check
	total-data-ordering-never
"
IUSE_EXPAND="OFI_MR TOTAL_DATA_ORDERING"
IUSE="${IUSE_OFI_MR} ${IUSE_TOTAL_DATA_ORDERING} av-map bounce-buffers cma completion-polling cxx
debug error-checking fortran long-fortran-header manual-progress memcpy ofi ofi-fence openmp
+pmi-mpi pmi-simple portals4 profiling pthread-mutexes remote-virtual-addressing threads
thread-completion ucx xpmem"

RDEPEND="
	ofi? ( sys-block/libfabric )
	pmi-simple? ( sys-cluster/pmix[pmi] )
	pmi-mpi? ( virtual/mpi )
	portals4? ( sys-cluster/portals4 )
	ucx? ( sys-cluster/ucx )
	xpmem? ( sys-kernel/xpmem )
"
DEPEND="${RDEPEND}"

REQUIRED_USE="
	^^ ( ${IUSE_OFI_MR/+/} )
	^^ ( ${IUSE_TOTAL_DATA_ORDERING/+/} )
	^^ ( pmi-mpi pmi-simple )
	?? ( cma xpmem )
	?? ( ofi portals4 )
"

pkg_setup() {
	FORTRAN_NEED_OPENMP=0
	use openmp && FORTRAN_NEED_OPENMP=1

	fortran-2_pkg_setup
}

src_prepare() {
	default

	#copied from bootstrap
	if [[ ! -d ./config ]]; then
		mkdir ./config || die
	fi
	FILES=./man/*.1
	echo -n "dist_man1_MANS =" > ./man/Makefile.am || die
	for f in $FILES
	do
		echo -n " $(basename $f)" >> ./man/Makefile.am || die
	done
	FILES=./man/*.3
	echo -e -n "\ndist_man3_MANS =" >> ./man/Makefile.am || die
	for f in $FILES
	do
		echo -n " $(basename $f)" >> ./man/Makefile.am || die
	done
	echo -e "\n" >> ./man/Makefile.am || die

	eautoreconf
}

src_configure() {
	local ofimr
	use ofi-mr-basic && ofimr="basic"
	use ofi-mr-scalable && ofimr="scalable"
	use ofi-mr-rma-event && ofimr="rma-event"

	local tda
	use total-data-ordering-always && tda="always"
	use total-data-ordering-check && tda="check"
	use total-data-ordering-never && tda="never"

	local myconf=(
		--disable-picky
		--disable-rpm-prefix
		--enable-ofi-mr="${ofimr}"
		--enable-total-data-ordering="${tda}"
		$(use_enable av-map)
		$(use_enable bounce-buffers)
		$(use_enable completion-polling)
		$(use_enable cxx)
		$(use_enable debug)
		$(use_enable error-checking)
		$(use_enable fortran)
		$(use_enable long-fortran-header)
		$(use_enable manual-progress)
		$(use_enable memcpy)
		$(use_enable ofi-fence)
		$(use_enable openmp)
		$(use_enable pmi-mpi)
		$(use_enable pmi-simple)
		$(use_enable profiling)
		$(use_enable pthread-mutexes)
		$(use_enable remote-virtual-addressing)
		$(use_enable threads)
		$(use_enable thread-completion)

		$(use_with cma)
		$(use_with ofi)
		$(use_with pmi-mpi pmi)
		$(use_with portals4)
		$(use_with ucx)
		$(use_with xpmem)
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
