# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson xdg

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://codeberg.org/dnkl/foot/archive/${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
else
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/dnkl/foot.git"
fi

DESCRIPTION="A fast, lightweight and minimalistic Wayland terminal emulator"
HOMEPAGE="https://codeberg.org/dnkl/foot"
LICENSE="MIT"
SLOT="0"
IUSE="ime +grapheme-clustering"

DEPEND="
	dev-libs/libutf8proc
	dev-libs/wayland
	media-libs/fcft
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libxkbcommon
	x11-libs/pixman
"
RDEPEND="
	${DEPEND}
	|| (
		>=sys-libs/ncurses-6.3
		gui-apps/foot-terminfo
	)
"
BDEPEND="
	app-text/scdoc
	dev-libs/tllist
	dev-libs/wayland-protocols
	sys-libs/ncurses
"

src_configure() {
	local emesonargs=(
		$(meson_use ime)
		$(meson_feature grapheme-clustering)
		"-Dterminfo=disabled"
		"-Dwerror=false"
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	mv "${D}/usr/share/doc/${PN}" "${D}/usr/share/doc/${PF}" || die
}
