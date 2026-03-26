# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( luajit )
inherit eapi9-ver lua-single meson xdg

DESCRIPTION="Lightweight image viewer for Wayland display servers"
HOMEPAGE="https://github.com/artemsen/swayimg"
SRC_URI="https://github.com/artemsen/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="avif bash-completion drm exif exr gif heif jpeg jpegxl png raw sixel svg test tiff +wayland webp X"
REQUIRED_USE="
	${LUA_REQUIRED_USE}
	|| ( drm wayland )
"
RESTRICT="!test? ( test )"

RDEPEND="
	${LUA_DEPS}
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libxkbcommon
	avif? ( >=media-libs/libavif-1.0:= )
	bash-completion? ( app-shells/bash-completion )
	drm? ( x11-libs/libdrm )
	exif? ( media-gfx/exiv2:= )
	exr? ( >=media-libs/openexr-3.4:= )
	gif? ( media-libs/giflib:= )
	heif? ( media-libs/libheif:= )
	jpeg? ( media-libs/libjpeg-turbo:= )
	jpegxl? ( media-libs/libjxl:= )
	png? ( media-libs/libpng:= )
	raw? ( media-libs/libraw:= )
	sixel? ( media-libs/libsixel )
	svg? (
		dev-libs/glib:2
		>=gnome-base/librsvg-2.46:2
		x11-libs/cairo[X=]
	)
	tiff? ( media-libs/tiff:= )
	wayland? ( dev-libs/wayland )
	webp? ( media-libs/libwebp:= )
"
DEPEND="
	${RDEPEND}
	svg? ( X? ( x11-base/xorg-proto ) )
	test? ( dev-cpp/gtest )
	wayland? ( >=dev-libs/wayland-protocols-1.35 )
"
BDEPEND="
	wayland? ( dev-util/wayland-scanner )
"

PATCHES=(
	"${FILESDIR}"/${PN}-5.1-precompiled_doc.patch
)

DOCS=( CONFIG.md README.md USAGE.md )

src_configure() {
	local emesonargs=(
		$(meson_feature avif)
		$(meson_feature drm)
		$(meson_feature exif)
		$(meson_feature exr)
		$(meson_feature gif)
		$(meson_feature heif)
		$(meson_feature jpeg)
		$(meson_feature jpegxl jxl)
		$(meson_feature png)
		$(meson_feature raw)
		$(meson_feature sixel)
		$(meson_feature svg)
		$(meson_feature test tests)
		$(meson_feature tiff)
		$(meson_feature wayland)
		$(meson_feature wayland compositor)
		$(meson_feature webp)
		$(meson_feature bash-completion bash)
		-Dversion=${PV}
		-Ddesktop=true
		-Ddoc=false
		-Dlicense=false
		-Dluameta=true
		-Dman=true
		-Dzsh=enabled
	)
	meson_src_configure
}

src_test() {
	# Set LC_COLLATE=en_US.utf8 if available for ImageListTest.SortAlphaUnicode
	if locale -a | grep -iq "en_US.utf8"; then
		local -x LC_COLLATE="en_US.utf8"
	else
		local -x GTEST_FILTER="-ImageListTest.SortAlphaUnicode"
	fi
	meson_src_test
}

pkg_postinst() {
	xdg_pkg_postinst

	if ver_replacing -lt 5.0; then
		elog "The Swayimg configuration file is now a Lua script."
		elog "${EROOT}/usr/share/swayimg/swayimg.lua contains a description of Lua bindings."
		elog "${EROOT}/usr/share/swayimg/example.lua contains a detailed example."
		elog "The new user config file is ~/.config/swayimg/init.lua"
	fi
}
