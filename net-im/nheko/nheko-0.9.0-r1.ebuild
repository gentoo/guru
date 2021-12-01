# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature xdg

DESCRIPTION="Desktop client for Matrix using Qt and C++14"
HOMEPAGE="https://github.com/Nheko-Reborn/nheko"
SRC_URI="https://github.com/Nheko-Reborn/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X pipewire video voip"
REQUIRED_USE="video? ( voip )"

MY_GST_V="1.18"
RDEPEND="
	app-text/cmark
	dev-cpp/qt-jdenticon
	>=dev-db/lmdb++-1.0.0
	>=dev-libs/mtxclient-0.6.0
	>=dev-libs/qtkeychain-0.12.0
	dev-libs/spdlog
	dev-qt/qtconcurrent:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtgui:5[gif,jpeg,png]
	dev-qt/qtimageformats
	dev-qt/qtmultimedia:5[gstreamer,qml]
	dev-qt/qtquickcontrols2:5
	dev-qt/qtsvg:5
	pipewire? ( media-video/pipewire[gstreamer] )
	voip? (
		>=media-plugins/gst-plugins-dtls-${MY_GST_V}
		media-plugins/gst-plugins-libnice
		>=media-plugins/gst-plugins-meta-${MY_GST_V}[opus]
		>=media-plugins/gst-plugins-srtp-${MY_GST_V}
		>=media-plugins/gst-plugins-webrtc-${MY_GST_V}
		video? (
			>=media-libs/gst-plugins-base-${MY_GST_V}[opengl]
			>=media-plugins/gst-plugins-meta-${MY_GST_V}[v4l,vpx]
			>=media-plugins/gst-plugins-qt5-${MY_GST_V}
			X? (
				>=media-plugins/gst-plugins-ximagesrc-${MY_GST_V}
				x11-libs/xcb-util-wm
			)
		)
	)
"
DEPEND="
	dev-cpp/nlohmann_json
	${RDEPEND}
"
BDEPEND="dev-qt/linguist-tools:5"

src_configure() {
	local -a mycmakeargs=(
		"-DVOIP=$(usex voip)"
	)
	if use video && use X; then
		mycmakeargs+=("-DSCREENSHARE_X11=yes")
	else
		mycmakeargs+=("-DSCREENSHARE_X11=no")
	fi

	cmake_src_configure
}

pkg_postinst() {
	optfeature "Audio & video file playback support" \
			   "media-plugins/gst-plugins-meta[ffmpeg]"

	xdg_pkg_postinst
}
