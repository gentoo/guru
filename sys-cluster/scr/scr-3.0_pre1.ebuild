# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DOCS_BUILDER="sphinx"
DOCS_DIR="${S}/doc/rst"
FORTRAN_NEEDED="fortran"
MYPV="${PV/_pre/rc}"
PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit cmake python-single-r1 fortran-2 docs

DESCRIPTION="Scalable Checkpoint / Restart Library"
HOMEPAGE="
	http://computing.llnl.gov/projects/scalable-checkpoint-restart-for-mpi
	https://github.com/LLNL/scr
"
SRC_URI="https://github.com/LLNL/scr/archive/refs/tags/v${MYPV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples fcntl +flock +fortran mysql pdsh pmix slurm syslog txt-log +yogrt"

#cppr
RDEPEND="
	${PYTHON_DEPS}

	sys-cluster/AXL
	sys-cluster/dtcmp
	sys-cluster/er
	sys-cluster/KVTree
	sys-cluster/rankstr
	sys-cluster/redset
	sys-cluster/spath
	sys-libs/zlib
	virtual/mpi

	mysql? ( dev-db/mysql-connector-c  )
	pdsh? ( app-shells/pdsh )
	pmix? ( sys-cluster/pmix )
	slurm? ( sys-cluster/slurm )
	yogrt? ( sys-cluster/libyogrt[slurm?] )
"
DEPEND="${RDEPEND}"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}

	?? ( pmix slurm )
	?? ( fcntl flock )
"

pkg_setup() {
	fortran-2_pkg_setup
}

src_configure() {
	local asyncapi="NONE" #INTEL_CPPR

	local lock="NONE"
	use fcntl && lock="FCNTL"
	use flock && lock="FLOCK"

	local log="0"
	use syslog && log="1"
	use txt-log && log="1"

	local resman="NONE" #APRUN LSF
	use pmix && resman="PMIX"
	use slurm && resman="SLURM"

	local mycmakeargs=(
		-DBUILD_PDSH=OFF
		-DENABLE_INTEL_CPPR=OFF
		-DENABLE_ENABLE_CRAY_DW=OFF
		-DENABLE_IBM_BBAPI=OF
		-DSCR_ASYNC_API="${asyncapi}"
		-DSCR_FILE_LOCK="${lock}"
		-DSCR_LINK_STATIC=OFF
		-DSCR_LOG_ENABLE="${log}"
		-DSCR_RESOURCE_MANAGER="${resman}"

		-DENABLE_EXAMPLES=$(usex examples)
		-DENABLE_FORTRAN=$(usex fortran)
		-DENABLE_PDSH=$(usex pdsh)
		-DENABLE_TESTS=$(usex test)
		-DENABLE_YOGRT=$(usex yogrt)
		-DSCR_LOG_SYSLOG_ENABLE=$(usex syslog 0 1)
		-DSCR_LOG_TXT_ENABLE=$(usex txt-log 0 1)
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
	find "${ED}" -name '*.a' -delete || die
}
