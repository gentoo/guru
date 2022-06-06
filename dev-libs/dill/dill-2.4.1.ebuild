# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Provides instruction-level code generation directly into memory regions"
HOMEPAGE="https://github.com/GTkorvo/dill"
SRC_URI="https://github.com/GTKorvo/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="disassembly ignore-native multitarget test"

RDEPEND="
	dev-libs/libffi
	disassembly? ( sys-libs/binutils-libs )
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/binutils
	dev-lang/perl
"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DDILL_INSTALL_PKGCONFIG=ON
		-DDILL_INSTALL_HEADERS=ON
		-DDILL_QUIET=OFF
		-DLIBFFI_INTERNAL=OFF

		-DBUILD_TESTING=$(usex test)
		-DDILL_ENABLE_DISASSEMBLY=$(usex disassembly)
		-DDILL_IGNORE_NATIVE=$(usex ignore-native)
		-DDILL_MULTI_TARGET=$(usex multitarget)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
