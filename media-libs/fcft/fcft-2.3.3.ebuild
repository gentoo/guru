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
SLOT="0"
IUSE="+text-shaping"

DEPEND="
	dev-libs/tllist
	media-libs/fontconfig
	media-libs/freetype
	text-shaping? ( media-libs/harfbuzz )
	x11-libs/pixman
"
RDEPEND="${DEPEND}"
BDEPEND="app-text/scdoc"

src_configure() {
	local emesonargs=(
		$(meson_feature text-shaping)
		"-Dwerror=false"
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${PF}"
}
