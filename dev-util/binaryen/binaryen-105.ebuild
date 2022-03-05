# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Compiler and toolchain infrastructure library for WebAssembly"
HOMEPAGE="https://github.com/WebAssembly/binaryen"
SRC_URI="https://github.com/WebAssembly/binaryen/archive/version_${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/binaryen-version_${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_STATIC_LIB=OFF
		-DENABLE_WERROR=OFF
	)
	cmake_src_configure
}

src_test() {
	./check.py || die
}
