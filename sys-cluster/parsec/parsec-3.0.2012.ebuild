# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DOCS_BUILDER="doxygen"
DOCS_DIR="docs/doxygen"

inherit cmake fortran-2 docs

DESCRIPTION="Parallel Runtime Scheduler and Execution Controller for micro-tasks on distributed heterogeneous systems"
HOMEPAGE="https://bitbucket.org/icldistcomp/parsec"
SRC_URI="https://bitbucket.org/icldistcomp/parsec/get/${P}.tar.bz2"
S="${WORKDIR}/icldistcomp-${PN}-d2ae4175f072"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE_PARSEC_DEBUG="
	parsec-debug-history
	parsec-debug-mem-addr
	parsec-debug-mem-leak
	parsec-debug-mem-race
	parsec-debug-noisier
	parsec-debug-paranoid
"
IUSE_PARSEC_DIST="
	+parsec-dist-collectives
	+parsec-dist-priorities
	+parsec-dist-thread
"
IUSE_PARSEC_PROF="
	parsec-prof-active-arena-set
	parsec-prof-btf
	parsec-prof-dry-body
	parsec-prof-dry-dep
	parsec-prof-dry-run
	parsec-prof-grapher
	+parsec-prof-mmap
	parsec-prof-otf2
	parsec-prof-pins
	parsec-prof-ptg
	parsec-prof-rusage
	parsec-prof-scheduling-events
	+parsec-prof-thread
"
IUSE="${IUSE_PARSEC_DEBUG} ${IUSE_PARSEC_DIST} ${IUSE_PARSEC_PROF} +cxx debug +devel-headers fortran +home-config-files +mpi profile +sched-deps-mask sim test +tools"

#TODO: gd vite tau
RDEPEND="
	dev-util/valgrind
	sys-apps/hwloc
	sys-cluster/temanejo

	mpi? ( virtual/mpi )
	parsec-prof-otf2? ( sys-cluster/otf2 )
	parsec-prof-pins? ( dev-libs/papi )
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/bison
	sys-devel/flex
"

RESTRICT="!test? ( test )"
REQUIRED_USE="
	?? ( mpi sim )
	?? ( parsec-debug-mem-addr parsec-debug-mem-leak parsec-debug-mem-race )
	?? ( parsec-prof-btf parsec-prof-otf2 )
"

pkg_setup() {
	fortran-2_pkg_setup
}

src_configure() {
	local trace="Auto"
	use parsec-prof-btf && trace="PaRSEC Binary Tracing Format"
	use parsec-prof-otf2 && trace="OTF2"

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DPARSEC_GPU_CUDA_ALLOC_PER_TILE=OFF
		-DPARSEC_GPU_WITH_CUDA=OFF
		-DPARSEC_GPU_WITH_OPENCL=OFF
		-DPARSEC_PROF_TAU=OFF

		-DBUILD_TOOLS=$(usex tools)
		-DPARSEC_DEBUG=$(usex debug)
		-DPARSEC_DEBUG_HISTORY=$(usex parsec-debug-history)
		-DPARSEC_DEBUG_MEM_ADDR=$(usex parsec-debug-mem-addr)
		-DPARSEC_DEBUG_MEM_LEAK=$(usex parsec-debug-mem-leak)
		-DPARSEC_DEBUG_MEM_RACE=$(usex parsec-debug-mem-race)
		-DPARSEC_DEBUG_NOISIER=$(usex parsec-debug-noisier)
		-DPARSEC_DEBUG_PARANOID=$(usex parsec-debug-paranoid)
		-DPARSEC_DIST_COLLECTIVES=$(usex parsec-dist-collectives)
		-DPARSEC_DIST_PRIORITIES=$(usex parsec-dist-priorities)
		-DPARSEC_DIST_THREAD=$(usex parsec-dist-thread)
		-DPARSEC_DIST_WITH_MPI=$(usex mpi)
		-DPARSEC_SCHED_DEPS_MASK=$(usex sched-deps-mask)
		-DPARSEC_SIM=$(usex sim)
		-DPARSEC_PROF_DRY_BODY=$(usex parsec-prof-dry-body)
		-DPARSEC_PROF_DRY_DEP=$(usex parsec-prof-dry-dep)
		-DPARSEC_PROF_DRY_RUN=$(usex parsec-prof-dry-run)
		-DPARSEC_PROF_GRAPHER=$(usex parsec-prof-grapher)
		-DPARSEC_PROF_PINS=$(usex parsec-prof-pins)
		-DPARSEC_PROF_RUSAGE_EU=$(usex parsec-prof-rusage)
		-DPARSEC_PROF_TRACE=$(usex profile)
		-DPARSEC_PROF_TRACE_ACTIVE_ARENA_SET=$(usex parsec-prof-active-arena-set)
		-DPARSEC_PROF_TRACE_PTG_INTERNAL_INIT=$(usex parsec-prof-ptg)
		-DPARSEC_PROF_TRACE_SCHEDULING_EVENTS=$(usex parsec-prof-scheduling-events)
		-DPARSEC_PROF_TRACE_SYSTEM="${trace}"
		-DPARSEC_PROFILING_USE_HELPER_THREAD=$(usex parsec-prof-thread)
		-DPARSEC_PROFILING_USE_MMAP=$(usex parsec-prof-mmap)
		-DPARSEC_WANT_HOME_CONFIG_FILES=$(usex home-config-files)
		-DPARSEC_WITH_DEVEL_HEADERS=$(usex devel-headers)
		-DSUPPORT_CXX=$(usex cxx)
		-DSUPPORT_FORTRAN=$(usex fortran)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	docs_compile
}

src_install() {
	cmake_src_install
	einstalldocs
}
