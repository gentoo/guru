# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

DESCRIPTION="Massively Scalable Clustering"
HOMEPAGE="https://github.com/LLNL/muster"
SRC_URI="https://github.com/LLNL/muster/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc pmpi tests"

RDEPEND="
	dev-libs/boost:=
	virtual/mpi
"
DEPEND="${RDEPEND}"
BDEPEND="doc? ( app-doc/doxygen )"

src_prepare() {
	sed -e "s|DESTINATION lib|DESTINATION $(get_libdir)|g" -i src/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DINSTALL_TESTS=$(usex tests test)
		-DMUSTER_USE_PMPI=$(usex pmpi)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	if use doc; then
		doxygen || die
	fi
}

src_install() {
	cmake_src_install
	use doc && dodoc -r doc/html
	if use tests; then
		mkdir -p "${ED}/usr/libexec/${PN}/" || die
		mv "${ED}"/usr/bin/*-test "${ED}/usr/libexec/${PN}/" || die
	fi
}
