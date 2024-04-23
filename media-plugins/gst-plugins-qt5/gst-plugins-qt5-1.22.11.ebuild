# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer-meson qmake-utils

DESCRIPTION="Qt5 QML video sink plugin for GStreamer"

LICENSE="GPL-2+"
KEYWORDS="~amd64"
IUSE="+X eglfs wayland"
REQUIRED_USE="
	|| ( X eglfs wayland )
	eglfs? ( kernel_linux )
"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	>=media-libs/gst-plugins-base-${PV}:${SLOT}[X?,opengl,wayland?]
	media-libs/mesa[wayland?,X?]
	X? ( dev-qt/qtx11extras:5 )
	eglfs? (
		dev-qt/qtgui:5[eglfs]
		media-libs/gst-plugins-base:${SLOT}[egl]
	)
	wayland? (
		dev-qt/qtwayland:5
		media-libs/gst-plugins-base:${SLOT}[egl]
	)
"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/linguist-tools"

GST_PLUGINS_BUILD_DIR="qt"

src_prepare() {
	export PATH="${PATH}:$(qt5_get_bindir)"
	default
}

multilib_src_configure() {
	local emesonargs=(
		$(meson_feature X qt-x11)
		$(meson_feature eglfs qt-egl)
		$(meson_feature wayland qt-wayland)
	)

	gstreamer_multilib_src_configure
}
