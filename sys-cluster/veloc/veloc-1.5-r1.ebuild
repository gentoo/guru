# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{8..10} )

inherit cmake distutils-r1

DESCRIPTION="Very-Low Overhead Checkpointing System"
HOMEPAGE="https://github.com/ECP-VeloC/VELOC"
SRC_URI="https://github.com/ECP-VeloC/VELOC/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN^^}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE_COMM_QUEUE="
	+comm-queue-ipc
	comm-queue-socket
"
#	comm-queue-thallium
IUSE="${IUSE_COMM_QUEUE} python +slurm"

RDEPEND="
	comm-queue-ipc? ( dev-libs/boost )
	slurm? ( sys-cluster/slurm )

	app-shells/pdsh
	dev-libs/openssl
	<sys-cluster/AXL-0.4.0
	sys-cluster/er
	virtual/mpi
"
#	comm-queue-thallium? ( thallium )
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${PN}-strip-cflags.patch" )
# Tests not working with python yet
#RESTRICT="python? ( test )"
REQUIRED_USE="
	^^ ( ${IUSE_COMM_QUEUE/+/} )
"

distutils_enable_sphinx "${S}/docs" --no-autodoc
distutils_enable_tests pytest

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local resman="NONE"
	use slurm && resman="SLURM"

	local queue
	use comm-queue-ipc && queue="ipc_queue"
	use comm-queue-socket && queue="socket_queue"
#	use comm-queue-thallium && queue="thallium_queue"

	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="$(get_libdir)"
		-DCOMM_QUEUE="${queue}"
		-DVELOC_RESOURCE_MANAGER="${resman}"
		-DX_LIBDIR="$(get_libdir)"
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	if use python; then
		pushd "src/bindings/python" || die
		distutils-r1_src_compile
		popd || die
	else
		# If USE="-python doc" we still
		# want to compile the doc files
		sphinx_compile_all
	fi
}

src_install() {
	cmake_src_install
	if use python; then
		pushd "${S}/src/bindings/python" || die
		distutils-r1_src_install
		popd || die
	fi
}

src_test() {
	cd test
	default
	if use python; then
		pushd "${S}/src/bindings/python" || die
#		python_test() {
#			"${EPYTHON}" test.py -v || die
#		}
		distutils-r1_src_test
		popd || die
	fi
}
