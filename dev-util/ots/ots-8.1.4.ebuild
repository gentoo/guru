# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

SRC_URI="https://github.com/khaledhosny/ots/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="An util for validating and sanitising OpenType files"
HOMEPAGE="https://github.com/khaledhosny/ots"
LICENSE="BSD"
SLOT="0"
IUSE="debug sanitize test"
RESTRICT="!test? ( test )"

RDEPEND="
	media-libs/freetype
	media-libs/woff2
	sys-libs/zlib

	sanitize? ( app-arch/lz4 )
"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/gtest )
"

DOCS=(
	README.md
	docs/{DesignDoc,HowToFix,HowToTest}.md
)

PATCHES=( "${FILESDIR}/meson-gtest.diff" )

src_configure() {
	local emesonargs=(
		$(meson_use debug)
		$(meson_use sanitize graphite)
		$(meson_use test tests)
	)
	meson_src_configure
}
