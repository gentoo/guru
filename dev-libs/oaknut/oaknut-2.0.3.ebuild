# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Yet another AArch64 emitter"
# This is a fork of the `merryhime/oaknut` repository
HOMEPAGE="https://github.com/eden-emulator/oaknut"
SRC_URI="https://github.com/eden-emulator/oaknut/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	test? ( dev-cpp/catch )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
	)

	cmake_src_configure
}
