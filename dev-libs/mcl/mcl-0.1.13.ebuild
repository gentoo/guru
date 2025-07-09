# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="merry's common library"
HOMEPAGE="https://github.com/merryhime/mcl"
SRC_URI="https://github.com/merryhime/mcl/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
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
	)

	cmake_src_configure
}
