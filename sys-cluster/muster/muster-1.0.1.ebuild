# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DOCS_BUILDER="doxygen"
DOCS_DIR="${S}"

inherit cmake docs

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

src_prepare() {
	sed -e "s|DESTINATION lib|DESTINATION $(get_libdir)|g" -i src/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DINSTALL_TESTS=$(usex tests)
		-DMUSTER_USE_PMPI=$(usex pmpi)
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
	if use tests; then
		mkdir -p "${ED}/usr/libexec/${PN}/" || die
		mv "${ED}"/usr/bin/*-test "${ED}/usr/libexec/${PN}/" || die
	fi
}
