# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Search tool for EPUB ebooks"
HOMEPAGE="https://schlomp.space/tastytea/epubgrep"
SRC_URI="https://schlomp.space/tastytea/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/boost[nls]
	app-arch/libarchive[bzip2,iconv,lzma,zlib]
	dev-libs/libfmt
"
DEPEND="
	${RDEPEND}
	dev-cpp/termcolor
	test? ( dev-cpp/catch )
"
BDEPEND="
	sys-devel/gettext
	app-text/asciidoc
"

src_configure() {
	local mycmakeargs=(
		"-DWITH_TESTS=$(usex test)"
		"-DFALLBACK_BUNDLED=NO"
	)

	cmake_src_configure
}

src_test() {
	BUILD_DIR="${BUILD_DIR}/tests" cmake_src_test
}
