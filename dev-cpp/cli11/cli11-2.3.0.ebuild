# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="doxygen"
DOCS_DIR="docs"
inherit cmake docs

DESCRIPTION="Command line parser for C++11"
HOMEPAGE="https://github.com/CLIUtils/CLI11 https://cliutils.github.io/CLI11/book/"
SRC_URI="https://github.com/CLIUtils/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/CLI11-${PV}"

LICENSE="BSD"
SLOT="0/2"
KEYWORDS="~amd64 ~x86"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="test? (
	<dev-cpp/catch-3:0
	dev-libs/boost
)"

DOCS=( README.md CHANGELOG.md )

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
