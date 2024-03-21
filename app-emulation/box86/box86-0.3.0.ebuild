# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature flag-o-matic

DESCRIPTION="Linux Userspace x86 Emulator with a twist"
HOMEPAGE="https://box86.org"
SRC_URI="https://github.com/ptitSeb/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~arm ~arm64"
IUSE="aot"
REQUIRED_USE="aot? ( || ( arm arm64 ) )" #depends on NEON, VFPv3, and non-thumb ABI, I see no good way to check

RDEPEND="${DEPEND}"

src_configure() {
	local -a mycmakeargs=(
		-DNOGIT=1
		-DARM_DYNAREC=$(usex aot)
	)

	use amd64 && mycmakeargs+=( -DLD80BITS=1 -DNOALIGN=1 )

	append-flags "-m32"

	cmake_src_configure
}

pkg_postinst() {
	optfeature "OpenGL for GLES devices" \
		"media-libs/gl4es"
}
