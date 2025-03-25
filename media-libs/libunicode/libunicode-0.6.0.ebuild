# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

UCD_VERSION="16.0.0"

DESCRIPTION="Modern C++20 Unicode library"
HOMEPAGE="https://github.com/contour-terminal/libunicode"
SRC_URI="
	https://github.com/contour-terminal/libunicode/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://www.unicode.org/Public/${UCD_VERSION}/ucd/UCD.zip -> ${P}-ucd.zip
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="
	test? (
		dev-cpp/catch
	)
"

RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

src_unpack() {
	unpack ${P}.tar.gz
	mkdir -p "${P}/_ucd/ucd-${UCD_VERSION}" || die
	unzip "${DISTDIR}/${P}-ucd.zip" -d "${P}/_ucd/ucd-${UCD_VERSION}" || die
}

src_prepare() {
	sed -i '/test_main.cpp/d' src/libunicode/CMakeLists.txt || die
	sed -i 's/Catch2::Catch2WithMain/Catch2Main Catch2::Catch2/g' src/libunicode/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCCACHE=Off
		-DLIBUNICODE_TESTING=$(usex test)
		-DLIBUNICODE_TOOLS=Off
	)

	cmake_src_configure
}
