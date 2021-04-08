# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

SRC_URI="https://github.com/ECP-VeloC/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
DESCRIPTION="KVTree provides a fully extensible C data structure modeled after Perl hashes"
HOMEPAGE="https://github.com/ECP-VeloC/KVTree"
LICENSE="MIT"
SLOT="0"
IUSE="fcntl +flock mpi test"
REQUIRED_USE="
		?? ( fcntl flock )
"
RESTRICT="test? ( userpriv ) !test? ( test )"
RDEPEND="
	mpi? ( virtual/mpi )
	sys-libs/zlib
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-util/cmake-2.8
	app-admin/chrpath
"

src_prepare() {
	#do not build static library
	sed -i '/kvtree-static/d' src/CMakeLists.txt || die
	sed -i '/kvtree_base-static/d' src/CMakeLists.txt || die
	#do not install README.md automatically
	sed -i '/FILES README.md DESTINATION/d' CMakeLists.txt || die
	default
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DMPI="$(usex mpi ON OFF)"
		-DKVTREE_FILE_LOCK="$(usex flock FLOCK $(usex fcntl FCNTL NONE))"
		-DKVTREE_LINK_STATIC=FALSE
	)
	cmake_src_configure
}

src_install() {
	chrpath -d "${BUILD_DIR}/src/kvtree_print" || die
	cmake_src_install
	chrpath -d "${ED}/usr/$(get_libdir)/libkvtree.so" || die
	chrpath -d "${ED}/usr/$(get_libdir)/libkvtree_base.so" || die
	dodoc doc/rst/*.rst
	docinto "${DOCSDIR}/users"
	dodoc -r doc/rst/users/.
}
