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
	https://computing.llnl.gov/projects/scalable-checkpoint-restart-for-mpi
	https://github.com/LLNL/scr
"
SRC_URI="https://github.com/LLNL/scr/archive/refs/tags/v${MYPV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MYPV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples fcntl +flock +fortran mysql pmix slurm syslog test txt-log +yogrt"

#cppr
RDEPEND="
	${PYTHON_DEPS}

	app-shells/pdsh
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
RESTRICT="!test? ( test )"

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

	local resman="NONE"
	use pmix && resman="PMIX"
	use slurm && resman="SLURM"

	local mycmakeargs=(
		-DBUILD_PDSH=OFF
		-DENABLE_INTEL_CPPR=OFF
		-DENABLE_ENABLE_CRAY_DW=OFF
		-DENABLE_IBM_BBAPI=OFF
		-DENABLE_PDSH=ON
		-DSCR_ASYNC_API="${asyncapi}"
		-DSCR_FILE_LOCK="${lock}"
		-DSCR_LINK_STATIC=OFF
		-DSCR_LOG_ENABLE="${log}"
		-DSCR_RESOURCE_MANAGER="${resman}"

		-DENABLE_EXAMPLES=$(usex examples)
		-DENABLE_FORTRAN=$(usex fortran)
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
	find "${ED}" -name '*.a' -delete || die
}
