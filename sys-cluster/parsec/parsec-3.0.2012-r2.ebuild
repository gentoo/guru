# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="doxygen"
DOCS_DIR="docs/doxygen"
PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit cmake fortran-2 docs python-single-r1

DESCRIPTION="Parallel Runtime Scheduler and Execution Controller"
HOMEPAGE="
	https://github.com/icldisco/parsec
	https://bitbucket.org/icldistcomp/parsec
"
SRC_URI="https://github.com/ICLDisco/${PN}/archive/refs/tags/${P}.tar.gz"
S="${WORKDIR}/${PN}-${P}"

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
	+parsec_prof_pins
	parsec_prof_ptg-internal-init
	parsec_prof_rusage-eu
	parsec_prof_scheduling-events
	+parsec_prof_helper-thread
"
IUSE="
${IUSE_PARSEC_DEBUG} ${IUSE_PARSEC_DIST} ${IUSE_PARSEC_PROF}
+cxx debug +devel-headers fortran +home-config-files +mpi profile +sched-deps-mask sim test +tools
"

#TODO: opencl vite tau
RDEPEND="
	dev-debug/valgrind
	sys-apps/hwloc
	sys-cluster/temanejo

	mpi? ( virtual/mpi[threads] )
	parsec_prof_otf2? ( sys-cluster/otf2 )
	parsec_prof_pins? ( dev-libs/papi )
	tools? (
		profile? (
			${PYTHON_DEPS}
			sys-libs/zlib
			media-gfx/graphviz
			media-libs/gd:2[jpeg,png]
			$(python_gen_cond_dep 'dev-python/cython[${PYTHON_USEDEP}]')
		)
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/bison
	sys-devel/flex
"

RESTRICT="!test? ( test )"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	test? ( parsec_prof_pins )
	?? ( mpi sim )
	?? ( parsec_debug_noisier parsec_debug_history )
	?? ( parsec_prof_dry-body parsec_prof_dry-dep parsec_prof_dry-run )
	?? ( parsec_prof_btf parsec_prof_otf2 )
"
# next release
#	?? ( parsec_debug_mem-addr parsec_debug_mem-leak parsec_debug_mem-race )

pkg_setup() {
	fortran-2_pkg_setup
	python-single-r1_pkg_setup
}

src_prepare() {
	# cannot use ${D} in src_prepare, just skip this directory, it doesn't get installed
	sed -i -e '/profiling/d' tools/CMakeLists.txt || die

	# 810970 remove unwanted flags from parsec.pc
	sed -i -e "s/ @EXTRA_CFLAGS@//" -e "s/ @EXTRA_LDFLAGS@//" parsec/include/parsec.pc.in || die

	# 810961: 2 tests fail, 2 time out
	sed -i -e "/unit_dtd_war_shm/d" -e "/unit_dtd_war_mpi/d" tests/interfaces/superscalar/CMakeLists.txt || die
	sed -i -e "/unit_haar_tree_mpi/d" tests/haar-tree-project/CMakeLists.txt || die
	sed -i -e "/unit_merge_sort_mpi/d" tests/merge_sort/Testings.cmake || die

	cmake_src_prepare
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

		-DBUILD_TESTING=$(usex test)
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
		-DPARSEC_PROF_RUSAGE_EU=$(usex parsec_prof_rusage-eu)
		-DPARSEC_PROF_TRACE=$(usex profile)
		-DPARSEC_PROF_TRACE_ACTIVE_ARENA_SET=$(usex parsec_prof_active-arena-set)
		-DPARSEC_PROF_TRACE_PTG_INTERNAL_INIT=$(usex parsec_prof_ptg-internal-init)
		-DPARSEC_PROF_TRACE_SCHEDULING_EVENTS=$(usex parsec_prof_scheduling-events)
		-DPARSEC_PROF_TRACE_SYSTEM="${trace}"
		-DPARSEC_PROFILING_USE_HELPER_THREAD=$(usex parsec_prof_helper-thread)
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
