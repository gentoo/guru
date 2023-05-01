# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_NEEDED="fortran"
MYPN="${PN^^}"
PYTHON_COMPAT=( python3_10 )

inherit cmake python-single-r1 fortran-2

DESCRIPTION="Next generation of ADIOS developed in the Exascale Computing Program"
HOMEPAGE="
	https://csmd.ornl.gov/software/adios2
	https://github.com/ornladios/adios2
"
SRC_URI="https://github.com/ornladios/${MYPN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="blosc bzip2 endian-reverse examples fortran hdf5 mpi png profile python sodium sst szip test zeromq zfp"

RDEPEND="
	dev-cpp/nlohmann_json
	dev-cpp/yaml-cpp:=
	dev-libs/atl
	dev-libs/dill
	>dev-libs/ffs-1.6.0
	dev-libs/kwsys:=
	dev-libs/perfstubs:=[timers]
	dev-libs/pugixml
	net-libs/enet
	>net-libs/evpath-4.5.0

	blosc? ( dev-libs/c-blosc:= )
	bzip2? ( app-arch/bzip2 )
	hdf5? ( sci-libs/hdf5:=[mpi=] )
	mpi? ( virtual/mpi[cxx] )
	png? ( media-libs/libpng:= )
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
			dev-python/numpy[${PYTHON_USEDEP}]
			dev-python/pybind11[${PYTHON_USEDEP}]
		')
		mpi? ( $(python_gen_cond_dep 'dev-python/mpi4py[${PYTHON_USEDEP}]') )
	)
	sodium? ( dev-libs/libsodium:= )
	sst? ( sys-block/libfabric:= )
	szip? ( virtual/szip )
	zeromq? ( net-libs/zeromq:= )
	zfp? ( dev-libs/zfp )
"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/gtest )
"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${P}-system-libs.patch"
	"${FILESDIR}/${P}-sandbox.patch"
)
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

pkg_setup() {
	use fortran && fortran-2_pkg_setup
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DADIOS2_USE_BP5=OFF
		-DADIOS2_USE_CUDA=OFF
		-DADIOS2_USE_DataMan=OFF
		-DADIOS2_USE_DataSpaces=OFF
		-DADIOS2_USE_EXTERNAL_ATL=ON
		-DADIOS2_USE_EXTERNAL_DEPENDENCIES=ON
		-DADIOS2_USE_EXTERNAL_DILL=ON
		-DADIOS2_USE_EXTERNAL_ENET=ON
		-DADIOS2_USE_EXTERNAL_FFS=ON
		-DADIOS2_USE_EXTERNAL_EVPATH=ON
		-DADIOS2_USE_EXTERNAL_GTEST=ON
		-DADIOS2_USE_EXTERNAL_NLOHMANN_JSON=ON
		-DADIOS2_USE_EXTERNAL_PUGIXML=ON
		-DADIOS2_USE_EXTERNAL_PYBIND11=ON
		-DADIOS2_USE_EXTERNAL_YAMLCPP=ON
		-DADIOS2_USE_IME=OFF
		-DADIOS2_USE_LIBPRESSIO=OFF
		-DADIOS2_USE_MGARD=OFF

		-DADIOS2_BUILD_EXAMPLES="$(usex examples)"
		-DADIOS2_BUILD_EXAMPLES_EXPERIMENTAL="$(usex examples)"
		-DADIOS2_USE_Blosc="$(usex blosc)"
		-DADIOS2_USE_BZip2="$(usex bzip2)"
		-DADIOS2_USE_Endian_Reverse="$(usex endian-reverse)"
		-DADIOS2_USE_Fortran="$(usex fortran)"
		-DADIOS2_USE_HDF5="$(usex hdf5)"
		-DADIOS2_USE_MPI="$(usex mpi)"
		-DADIOS2_USE_PNG="$(usex png)"
		-DADIOS2_USE_Profiling="$(usex profile)"
		-DADIOS2_USE_Python="$(usex python)"
		-DADIOS2_USE_Sodium="$(usex sodium)"
		-DADIOS2_USE_SST="$(usex sst)"
		-DADIOS2_USE_SZ="$(usex szip)"
		-DADIOS2_USE_ZeroMQ="$(usex zeromq)"
		-DADIOS2_USE_ZFP="$(usex zfp)"
		-DBUILD_TESTING="$(usex python)"
	)
	cmake_src_configure
}

src_prepare() {
	rm -r thirdparty/{atl,dill,enet,EVPath,ffs,GTest,KWSys,mingw-w64,pugixml,pybind11,yaml-cpp} || die
	rm -r thirdparty/nlohmann_json/nlohmann_json_wrapper/single_include || die
	rm -r thirdparty/perfstubs/perfstubs || die
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	dodoc ReadMe.md
}
