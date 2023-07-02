# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="A lightweight image viewer for Wayland display servers"
HOMEPAGE="https://github.com/artemsen/swayimg"
SRC_URI="https://github.com/artemsen/swayimg/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/json-c
	dev-libs/wayland
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libxkbcommon
	bash-completion? ( app-shells/bash-completion )
	exif? ( media-libs/libexif )
	gif? ( media-libs/giflib )
	heif? ( media-libs/libheif )
	jpeg? ( media-libs/libjpeg-turbo )
	jpegxl? ( media-libs/libjxl )
	png? ( media-libs/libpng )
	svg? ( gnome-base/librsvg )
	tiff? ( media-libs/tiff )
	webp? ( media-libs/libwebp )"
DEPEND="${RDEPEND}
	dev-libs/wayland-protocols"
BDEPEND="dev-util/wayland-scanner"

IUSE="+exif +gif heif +jpeg jpegxl +png svg tiff webp bash-completion zsh-completion"

src_configure() {
	local emesonargs=(
		$(meson_feature exif)
		$(meson_feature gif)
		$(meson_feature heif)
		$(meson_feature jpeg)
		$(meson_feature jpegxl jxl)
		$(meson_feature png)
		$(meson_feature svg)
		$(meson_feature tiff)
		$(meson_feature webp)
		$(meson_feature bash-completion bash)
		$(meson_feature zsh-completion zsh)
		-Dversion=${PV}
		-Ddesktop=true
		-Dman=true
	)
	meson_src_configure
}
