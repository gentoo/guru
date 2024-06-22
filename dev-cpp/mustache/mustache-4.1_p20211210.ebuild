# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="04277d5552c6e46bee41a946b7d175a660ea1b3d"
DESCRIPTION="Mustache implementation for modern C++"
HOMEPAGE="https://github.com/kainjow/Mustache"
SRC_URI="https://github.com/kainjow/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/Mustache-${COMMIT}"
LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( <dev-cpp/catch-3 )"

PATCHES="${FILESDIR}"/${P}-unbundle-catch.patch

src_configure() {
	local mycmakeargs=(
		-DTESTS=$(usex test)
	)
	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}"/tests/mustache-unit-tests || die "Tests failed!"
}

src_install() {
	insinto /usr/include
	doins mustache.hpp
}
