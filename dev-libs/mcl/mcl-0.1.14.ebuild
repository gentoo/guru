# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="merry's common library"
# This is a fork of the `merryhime/mcl` repository
HOMEPAGE="https://github.com/azahar-emu/mcl"
SRC_URI="https://github.com/azahar-emu/mcl/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/libfmt:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? ( dev-cpp/catch )
"

PATCHES=(
	"${FILESDIR}"/${PN}-0.1.13-build-tests-only-when-requested.patch
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DMCL_WARNINGS_AS_ERRORS=no
	)

	cmake_src_configure
}
