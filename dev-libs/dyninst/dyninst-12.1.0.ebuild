# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake

DESCRIPTION="Tools for binary instrumentation, analysis, and modification"
HOMEPAGE="
	https://dyninst.org/dyninst
	https://github.com/dyninst/dyninst
"
SRC_URI="https://github.com/dyninst/dyninst/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc openmp valgrind"

RDEPEND="
	<dev-cpp/tbb-2021
	dev-libs/boost:=
	virtual/libelf
	virtual/mpi
	valgrind? ( dev-debug/valgrind )
"
DEPEND="${RDEPEND}"
BDEPEND="doc? ( dev-texlive/texlive-latex )"

src_configure() {
	local mycmakeargs=(
		-DENABLE_STATIC_LIBS=NO
		-DSTERILE_BUILD=ON

		-DADD_VALGRIND_ANNOTATIONS=$(usex valgrind)
		-DBUILD_DOCS=$(usex doc)
		-DUSE_OpenMP=$(usex openmp)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	einstalldocs
	if use doc; then
		mv "${ED}"/usr/share/doc/*.pdf "${ED}/usr/share/doc/${PF}" || die
	fi

	if [[ ! -e "${ED}/usr/$(get_libdir)" ]]; then
		mv "${ED}/usr/lib" "${ED}/usr/$(get_libdir)" || die
	fi

	mkdir -p "${ED}/usr/include/dyninst" || die
	mv "${ED}"/usr/include/*.h* "${ED}/usr/include/dyninst" || die

	find "${ED}" -name '*.a' -delete || die
}
