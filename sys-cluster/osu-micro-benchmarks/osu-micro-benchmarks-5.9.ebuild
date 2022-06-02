# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools edo toolchain-funcs

DESCRIPTION="MPI, OPC and many other benchmarks"
HOMEPAGE="https://mvapich.cse.ohio-state.edu/benchmarks/"
SRC_URI="https://mvapich.cse.ohio-state.edu/download/mvapich/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="openshmem rocm"

DEPEND="
	virtual/mpi

	openshmem? ( sys-cluster/SOS )
	rocm? ( dev-util/hip )
"
RDEPEND="${RDEPEND}"

# TODO: cuda upc++ NCCL

src_prepare() {
	default
	eautoreconf
	edo pushd "${WORKDIR}"
	edo cp -r "${S}" "${S}_mpi"
	use openshmem && edo cp -r "${S}" "${S}_oshm"
}

src_configure() {
	local myconf=(
		--disable-cuda
		--disable-ncclomb
		--disable-openacc
		--disable-static
		--enable-shared

		$(use_enable rocm)
	)

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" econf "${myconf[@]}"

	edo pushd "${S}_mpi"
	CC=mpicc CXX=mpicxx econf "${myconf[@]}"
	edo popd

	if use openshmem; then
		edo pushd "${S}_oshm"
		CC=oshcc CXX=oshc++ econf "${myconf[@]}"
		edo popd
	fi
}

src_compile() {
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" default

	edo pushd "${S}_mpi"
	CC=mpicc CXX=mpicxx default
	edo popd

	if use openshmem; then
		edo pushd "${S}_oshm"
		CC=oshcc CXX=oshc++ default
		edo popd
	fi
}

src_install() {
	default

	edo pushd "${S}_mpi"
	default
	edo popd

	if use openshmem; then
		edo pushd "${S}_oshm"
		default
		edo popd
	fi
}
