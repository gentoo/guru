# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DOCS_BUILDER="doxygen"
DOCS_DIR="docs/doxygen"

inherit cmake fortran-2 docs

DESCRIPTION="Parallel Runtime Scheduler and Execution Controller"
HOMEPAGE="https://bitbucket.org/icldistcomp/parsec"
SRC_URI="https://bitbucket.org/icldistcomp/parsec/get/${P}.tar.bz2"
S="${WORKDIR}/icldistcomp-${PN}-d2ae4175f072"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

# next release
#	parsec_debug_mem-addr
#	parsec_debug_mem-leak
#	parsec_debug_mem-race
IUSE_PARSEC_DEBUG="
	parsec_debug_history
	parsec_debug_noisier
	parsec_debug_paranoid
"
IUSE_PARSEC_DIST="
	+parsec_dist_collectives
	+parsec_dist_priorities
	+parsec_dist_thread
"
IUSE_PARSEC_PROF="
	parsec_prof_active-arena-set
	parsec_prof_btf
	parsec_prof_dry-body
	parsec_prof_dry-dep
	parsec_prof_dry-run
	parsec_prof_grapher
	+parsec_prof_mmap
	parsec_prof_otf2
	parsec_prof_pins
	parsec_prof_ptg
	parsec_prof_rusage
	parsec_prof_scheduling-events
	+parsec_prof_thread
"
IUSE="${IUSE_PARSEC_DEBUG} ${IUSE_PARSEC_DIST} ${IUSE_PARSEC_PROF} +cxx debug +devel-headers fortran +home-config-files +mpi profile +sched-deps-mask sim test +tools"

#TODO: gd vite tau
RDEPEND="
	dev-util/valgrind
	sys-apps/hwloc
	sys-cluster/temanejo

	mpi? ( virtual/mpi )
	parsec_prof_otf2? ( sys-cluster/otf2 )
	parsec_prof_pins? ( dev-libs/papi )
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/bison
	sys-devel/flex
"

RESTRICT="!test? ( test )"
REQUIRED_USE="
	?? ( mpi sim )
	?? ( parsec_debug_noisier parsec_debug_history )
	?? ( parsec_prof_dry-body parsec_prof_dry-dep parsec_prof_dry-run )
	?? ( parsec_prof_btf parsec_prof_otf2 )
"
# next release
#	?? ( parsec_debug_mem-addr parsec_debug_mem-leak parsec_debug_mem-race )

pkg_setup() {
	fortran-2_pkg_setup
}

src_configure() {
	local trace="Auto"
	use parsec_prof_btf && trace="PaRSEC Binary Tracing Format"
	use parsec_prof_otf2 && trace="OTF2"

# next release
#		-DPARSEC_DEBUG_MEM_ADDR=$(usex parsec_debug_mem-addr)
#		-DPARSEC_DEBUG_MEM_LEAK=$(usex parsec_debug_mem-leak)
#		-DPARSEC_DEBUG_MEM_RACE=$(usex parsec_debug_mem-race)
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DPARSEC_GPU_CUDA_ALLOC_PER_TILE=OFF
		-DPARSEC_GPU_WITH_CUDA=OFF
		-DPARSEC_GPU_WITH_OPENCL=OFF
		-DPARSEC_PROF_TAU=OFF

		-DBUILD_TOOLS=$(usex tools)
		-DPARSEC_DEBUG=$(usex debug)
		-DPARSEC_DEBUG_HISTORY=$(usex parsec_debug_history)
		-DPARSEC_DEBUG_NOISIER=$(usex parsec_debug_noisier)
		-DPARSEC_DEBUG_PARANOID=$(usex parsec_debug_paranoid)
		-DPARSEC_DIST_COLLECTIVES=$(usex parsec_dist_collectives)
		-DPARSEC_DIST_PRIORITIES=$(usex parsec_dist_priorities)
		-DPARSEC_DIST_THREAD=$(usex parsec_dist_thread)
		-DPARSEC_DIST_WITH_MPI=$(usex mpi)
		-DPARSEC_SCHED_DEPS_MASK=$(usex sched-deps-mask)
		-DPARSEC_SIM=$(usex sim)
		-DPARSEC_PROF_DRY_BODY=$(usex parsec_prof_dry-body)
		-DPARSEC_PROF_DRY_DEP=$(usex parsec_prof_dry-dep)
		-DPARSEC_PROF_DRY_RUN=$(usex parsec_prof_dry-run)
		-DPARSEC_PROF_GRAPHER=$(usex parsec_prof_grapher)
		-DPARSEC_PROF_PINS=$(usex parsec_prof_pins)
		-DPARSEC_PROF_RUSAGE_EU=$(usex parsec_prof_rusage)
		-DPARSEC_PROF_TRACE=$(usex profile)
		-DPARSEC_PROF_TRACE_ACTIVE_ARENA_SET=$(usex parsec_prof_active-arena-set)
		-DPARSEC_PROF_TRACE_PTG_INTERNAL_INIT=$(usex parsec_prof_ptg)
		-DPARSEC_PROF_TRACE_SCHEDULING_EVENTS=$(usex parsec_prof_scheduling-events)
		-DPARSEC_PROF_TRACE_SYSTEM="${trace}"
		-DPARSEC_PROFILING_USE_HELPER_THREAD=$(usex parsec_prof_thread)
		-DPARSEC_PROFILING_USE_MMAP=$(usex parsec_prof_mmap)
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
