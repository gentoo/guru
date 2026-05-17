# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://codeberg.org/dnkl/wbg.git"
	inherit git-r3
else
	SRC_URI="https://codeberg.org/dnkl/wbg/archive/${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
fi

DESCRIPTION="Super simple wallpaper application"
HOMEPAGE="https://codeberg.org/dnkl/wbg"

# ZLIB for nanosvg
LICENSE="MIT ZLIB"
SLOT="0"
IUSE="png jpeg webp"

RDEPEND="
	dev-libs/wayland
	x11-libs/pixman
	jpeg? ( media-libs/libjpeg-turbo:= )
	png? ( media-libs/libpng:= )
	webp? ( media-libs/libwebp:= )
"
DEPEND="
	${RDEPEND}
	dev-libs/tllist
"
BDEPEND="
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		$(meson_feature png)
		$(meson_feature jpeg)
		$(meson_feature webp)
		-Dsvg=true
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	dodoc README.md CHANGELOG.md
}
