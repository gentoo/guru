# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DOCS_BUILDER="doxygen"
DOCS_CONFIG_NAME="docs/Doxyfile"
inherit cmake docs

MY_PN="CLI11"
DESCRIPTION="Command line parser for C++11"
HOMEPAGE="https://github.com/CLIUtils/CLI11 https://cliutils.github.io/CLI11/book"
SRC_URI="https://github.com/CLIUtils/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DCLI11_BUILD_DOCS=OFF
		-DCLI11_BUILD_TESTS=OFF
		-DCLI11_BUILD_EXAMPLES=$(usex test)
		-DCLI11_BUILD_EXAMPLES_JSON=OFF
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	docs_compile
}
