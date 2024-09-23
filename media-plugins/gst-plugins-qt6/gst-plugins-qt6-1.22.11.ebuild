# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer-meson

DESCRIPTION="Qt6 QML video sink plugin for GStreamer"

LICENSE="GPL-2+"
KEYWORDS="~amd64"
IUSE="+X eglfs wayland"
REQUIRED_USE="
	|| ( X eglfs wayland )
	eglfs? ( kernel_linux )
"

RDEPEND="
	dev-qt/qtbase:6[X?,eglfs?,gui,wayland?]
	dev-qt/qtdeclarative:6
	>=media-libs/gst-plugins-base-${PV}:${SLOT}[X?,opengl,wayland?]
	media-libs/mesa[wayland?,X?]
	eglfs? ( media-libs/gst-plugins-base:${SLOT}[egl] )
	wayland? (
		dev-qt/qtwayland:6
		media-libs/gst-plugins-base:${SLOT}[egl]
	)
"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qtbase:6"

GST_PLUGINS_BUILD_DIR="qt6"

multilib_src_configure() {
	local emesonargs=(
		$(meson_feature X qt-x11)
		$(meson_feature eglfs qt-egl)
		$(meson_feature wayland qt-wayland)
	)

	gstreamer_multilib_src_configure
}
