# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="KVTree provides a fully extensible C data structure modeled after Perl hashes"
HOMEPAGE="https://github.com/ECP-VeloC/KVTree"
SRC_URI="https://github.com/ECP-VeloC/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"
IUSE="fcntl +flock mpi test"

RDEPEND="
	mpi? ( virtual/mpi )
	sys-libs/zlib
"
DEPEND="${RDEPEND}"
BDEPEND="app-admin/chrpath"

PATCHES=(
	"${FILESDIR}/${PN}-no-install-readme.patch"
	"${FILESDIR}/${P}-no-static.patch"
)
REQUIRED_USE="?? ( fcntl flock )"
RESTRICT="test? ( userpriv ) !test? ( test )"

src_configure() {
	local flock="NONE"
	use fcntl && flock="FCNTL"
	use flock && flock="FLOCK"

	local mycmakeargs=(
		-DENABLE_TESTS=$(usex test)
		-DMPI="$(usex mpi ON OFF)"
		-DKVTREE_FILE_LOCK="${flock}"

		-DBUILD_SHARED_LIBS=ON
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
