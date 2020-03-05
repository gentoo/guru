# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{6,7,8} )

inherit cmake-utils distutils-r1

DESCRIPTION="Very-Low Overhead Checkpointing System"
HOMEPAGE="https://github.com/ECP-VeloC/VELOC"
SRC_URI="https://github.com/ECP-VeloC/${PN^^}/archive/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="alps lsf python +slurm"
# Tests not working with python yet
RESTRICT="python? ( test )"

REQUIRED_USE="
		?? ( alps lsf slurm )
"

RDEPEND="
	slurm? ( sys-cluster/slurm )

	app-shells/pdsh
	>=dev-libs/boost-1.60.0
	sys-cluster/AXL
	sys-cluster/er
	virtual/mpi
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-util/cmake-2.8
"

S="${WORKDIR}/${PN^^}-${P}"

distutils_enable_sphinx "${S}/docs" --no-autodoc

src_prepare() {
	#strip CFLAGS
	sed -i 's/-O2 -g//g' CMakeLists.txt || die
	sed -i 's/LIBRARY DESTINATION lib/LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/g' src/modules/CMakeLists.txt || die
	sed -i 's/LIBRARY DESTINATION lib/LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/g' src/lib/CMakeLists.txt || die
	sed -i 's/LIBRARY DESTINATION lib/LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/g' src/backend/CMakeLists.txt || die
	#do not auto install README
#       sed -i '/FILES README.md DESTINATION/d' CMakeLists.txt || die
	default
	cmake-utils_src_prepare
}

src_configure() {
	RESMAN="NONE"
	use alps	&& RESMAN="ALPS"
	use lsf		&& RESMAN="LSF"
	use slurm	&& RESMAN="SLURM"

	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="$(get_libdir)"
		-DX_LIBDIR="$(get_libdir)"
	)
	cmake-utils_src_configure
}

src_compile() {
	default
	if use python; then
		cd "src/bindings/python"
		distutils-r1_src_compile
		cd "${S}"
	else
		# If USE="-python doc" we still
		# want to compile the doc files
		sphinx_compile_all
	fi
}

src_install() {
	cmake-utils_src_install
	if use python; then
		cd "${S}/src/bindings/python"
		distutils-r1_src_install
	fi
}

src_test() {
	cd test
	default
	if use python; then
		cd "${S}/src/bindings/python"
		python_test() {
			"${EPYTHON}" test.py -v || die
		}
		distutils-r1_src_test
	fi
}
