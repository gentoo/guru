# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

EGIT_COMMIT="fa6cc2e4b2a2954f2298b6548174479c5b106c2a"

DESCRIPTION="An ARM dynamic recompiler"
# This is a copy of the now-deleted repository `merryhime/dynarmic`
HOMEPAGE="https://github.com/lioncash/dynarmic"
SRC_URI="https://github.com/lioncash/dynarmic/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/robin-map
	dev-libs/boost:=
	dev-libs/libfmt:=
	dev-libs/mcl
	amd64? ( dev-libs/zydis )
"
DEPEND="
	${RDEPEND}
	amd64? ( >=dev-libs/xbyak-7.25 )
	arm64? ( dev-libs/oaknut )
"
BDEPEND="
	test? (
		dev-cpp/catch
		dev-libs/oaknut
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-6.7.0-add-xbyak-as-a-system-library-rather-than-a-cmake-package.patch"
	"${FILESDIR}/${PN}-6.7.0-relax-the-dependency-on-mcl.patch"
)

src_prepare() {
	find externals -mindepth 1 -not -path "externals/CMakeLists.txt" -delete

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DDYNARMIC_USE_PRECOMPILED_HEADERS=no
		-DDYNARMIC_TESTS=$(usex test)
		-Wno-dev
	)

	cmake_src_configure
}
