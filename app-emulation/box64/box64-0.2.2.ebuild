# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature

DESCRIPTION="Linux Userspace x86_64 Emulator with a twist"
HOMEPAGE="https://box86.org"
SRC_URI="https://github.com/ptitSeb/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm64 ~ppc64"
IUSE="aot"
REQUIRED_USE="aot? ( arm64 )"

RDEPEND="${DEPEND}"

src_configure() {
	local -a mycmakeargs=(
		-DNOGIT=1
		-DARM_DYNAREC=$(usex aot)
	)

	use ppc64 && mycmakeargs+=( -DPPC64LE=1 )
	use riscv && mycmakeargs+=( -DRV64=1 )
	use loong && mycmakeargs+=( -DLARCH64=1 )
	use amd64 && mycmakeargs+=( -DLD80BITS=1 -DNOALIGN=1 )

	cmake_src_configure
}

pkg_postinst() {
	optfeature "OpenGL for GLES devices" \
		"media-libs/gl4es"
}
