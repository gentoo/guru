# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://codeberg.org/dnkl/fcft/archive/${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
else
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/fcft.git"
fi

DESCRIPTION="A simple library for font loading and glyph rasterization"
HOMEPAGE="https://codeberg.org/dnkl/fcft"
LICENSE="MIT"
SLOT="0/3"
IUSE="examples +text-shaping test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/tllist
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/pixman
	text-shaping? ( media-libs/harfbuzz )
	examples? (
		dev-libs/libutf8proc:=
		dev-libs/wayland
	)
"
DEPEND="
	${RDEPEND}
	test? (
		text-shaping? ( media-fonts/noto-emoji )
	)
"
BDEPEND="
	app-text/scdoc
	app-i18n/unicode-data
	examples? (
		dev-libs/wayland-protocols
		dev-util/wayland-scanner
	)
"

src_prepare() {
	default

	rm -r "unicode" || die "Failed removing vendored unicode-data"

	sed -i "s;unicode/UnicodeData.txt;${EPREFIX}/usr/share/unicode-data/UnicodeData.txt;" \
		meson.build || die "Failed changing UnicodeData.txt to system's copy"
}

src_configure() {
	local emesonargs=(
		$(meson_feature text-shaping)
		$(meson_use examples)
		"-Dwerror=false"
	)

	use test && emesonargs+=(
		$(meson_use text-shaping test-text-shaping)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	use examples && newbin "${BUILD_DIR}/example/example" fcft-example
	mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${PF}"
}
