# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake vcs-snapshot

EGIT_COMMIT="4ab79a8c023aa63caaa93848b09b9fe8b183b1a9"

DESCRIPTION="A runtime SPIR-V assembler"
HOMEPAGE="https://github.com/PabloMK7/sirit"
SRC_URI="https://github.com/PabloMK7/sirit/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-util/spirv-headers"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DSIRIT_USE_SYSTEM_SPIRV_HEADERS=ON
	)
	cmake_src_configure
}

src_install() {
	dodoc LICENSE.txt README.md
	dolib.so "${BUILD_DIR}/src/libsirit.so"
	doheader -r include/sirit
}
