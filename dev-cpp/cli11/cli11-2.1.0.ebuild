# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="doxygen"
DOCS_DIR="docs"
inherit cmake docs

CATCH_PV=2.13.6
DESCRIPTION="Command line parser for C++11"
HOMEPAGE="https://github.com/CLIUtils/CLI11 https://cliutils.github.io/CLI11/book"
SRC_URI="
	https://github.com/CLIUtils/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/philsquared/Catch/releases/download/v${CATCH_PV}/catch.hpp -> catch-${CATCH_PV}.hpp )
"
S="${WORKDIR}/CLI11-${PV}"

LICENSE="BSD"
SLOT="0/2"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS=( README.md CHANGELOG.md )

src_unpack() {
	unpack ${P}.tar.gz

	# work around cmake's file(DOWNLOAD ...)
	cd "${S}" || die
	if use test; then
		_cmake_check_build_dir
		mkdir "${BUILD_DIR}"/tests || die
		cp "${DISTDIR}"/catch-${CATCH_PV}.hpp "${BUILD_DIR}"/tests/catch.hpp || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DCLI11_BUILD_DOCS=OFF  # handled by docs.eclass
		-DCLI11_BUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	docs_compile
}
