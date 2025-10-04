# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A runtime SPIR-V assembler"
HOMEPAGE="https://github.com/eden-emulator/sirit"
SRC_URI="https://github.com/eden-emulator/sirit/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-util/spirv-headers"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DSIRIT_USE_SYSTEM_SPIRV_HEADERS=ON

		-DSIRIT_TESTS=$(usex test)
	)
	cmake_src_configure
}
