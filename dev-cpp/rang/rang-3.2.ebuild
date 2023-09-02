# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Minimal, header-only, modern C++ library for terminal goodies"
HOMEPAGE="https://agauniyal.github.io/rang/"
SRC_URI="https://github.com/agauniyal/rang/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.gh.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

PATCHES="${FILESDIR}/${P}-fix-tests.patch"

BDEPEND="test? ( dev-cpp/doctest )"

src_configure() {
	cmake_src_configure
	if use test; then
		local BUILD_DIR CMAKE_USE_DIR
		BUILD_DIR="${WORKDIR}/${P}_test"
		CMAKE_USE_DIR="${S}/test"
		cmake_src_configure
	fi
}

src_compile() {
	if use test; then
		local BUILD_DIR CMAKE_USE_DIR
		BUILD_DIR="${WORKDIR}/${P}_test"
		CMAKE_USE_DIR="${S}/test"
		cmake_src_compile
	fi
}

src_test() {
	local BUILD_DIR CMAKE_USE_DIR
	BUILD_DIR="${WORKDIR}/${P}_test"
	CMAKE_USE_DIR="${S}/test"
	cmake_src_test
}
