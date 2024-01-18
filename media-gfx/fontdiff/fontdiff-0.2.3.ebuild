# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

SRC_URI="https://github.com/googlefonts/fontdiff/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
DESCRIPTION="A tool for finding visual differences between two font versions"
HOMEPAGE="https://github.com/googlei18n/fontdiff"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="
	app-i18n/unicode-data
	app-i18n/unicode-emoji
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/icu:=
	dev-util/ragel
	>=media-libs/freetype-2.9:2
	>=media-libs/harfbuzz-1.7.4[icu]
	x11-libs/cairo
	x11-libs/pixman
"
DEPEND="
	${RDEPEND}
	dev-cpp/dtl
	dev-build/gyp
"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-cairo114.diff"
	"${FILESDIR}/${PN}-hbicu.diff"
	"${FILESDIR}/${P}-no-bundled-libs.patch"
)

src_prepare() {
	#no bundled libs
	rm -r src/third_party || die
	default
}

src_configure() {
	gyp -f make --depth . "${S}/src/fontdiff/fontdiff.gyp" || die
}

src_compile() {
	local _pc="$(tc-getPKG_CONFIG)"
	local _d="cairo expat freetype2 harfbuzz-icu icu-uc"
	local myargs=(
		CXX=$(tc-getCXX)
		CC=$(tc-getCC)
		AR=$(tc-getAR)
		LIBS="$(${_pc} --libs ${_d})"
		CPPFLAGS="$(${_pc} --cflags ${_d})"
		V=1
	)

	emake "${myargs[@]}"
}

src_install() {
	dobin "${S}/out/Default/${PN}"
	einstalldocs
}
