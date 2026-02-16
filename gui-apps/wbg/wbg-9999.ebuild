# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

EGIT_REPO_URI="https://codeberg.org/dnkl/wbg.git"

DESCRIPTION="Super simple wallpaper application"
HOMEPAGE="https://codeberg.org/dnkl/wbg"

# ZLIB for nanosvg
LICENSE="MIT ZLIB"
SLOT="0"
IUSE="jpeg jpegxl png webp +svg system-nanosvg"

REQUIRED_USE="
	|| ( jpeg jpegxl png webp svg )
	system-nanosvg? ( svg )
"

RDEPEND="
	dev-libs/wayland
	x11-libs/pixman
	jpeg? ( media-libs/libjpeg-turbo:= )
	jpegxl? ( media-libs/libjxl:= )
	png? ( media-libs/libpng:= )
	webp? ( media-libs/libwebp:= )
	system-nanosvg? ( media-libs/nanosvg:= )
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
		$(meson_feature jpeg)
		$(meson_feature jpegxl jxl)
		$(meson_feature png)
		$(meson_feature webp)
		$(meson_feature system-nanosvg)
		$(meson_use svg)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	dodoc README.md CHANGELOG.md
}
