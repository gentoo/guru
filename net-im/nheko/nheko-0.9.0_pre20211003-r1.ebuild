# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_COMMIT="c43c2bd4b9481f761e9f1b16453f0e7f5b1beabe"
DESCRIPTION="Native desktop client for Matrix using Qt"
HOMEPAGE="https://github.com/Nheko-Reborn/nheko"
SRC_URI="https://github.com/Nheko-Reborn/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="video voip"
REQUIRED_USE="video? ( voip )"

MY_GST_V="1.18"
RDEPEND="
	app-text/cmark
	>=dev-db/lmdb++-1.0.0
	>=dev-libs/mtxclient-0.5.2_pre20210916
	>=dev-libs/qtkeychain-0.12.0
	dev-libs/spdlog
	dev-qt/qtconcurrent:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtgui:5[gif,jpeg,png]
	dev-qt/qtmultimedia:5[qml]
	dev-qt/qtquickcontrols2:5
	dev-qt/qtsvg:5
	voip? (
		dev-qt/qtmultimedia:5[gstreamer]
		>=media-plugins/gst-plugins-dtls-${MY_GST_V}
		media-plugins/gst-plugins-libnice
		>=media-plugins/gst-plugins-meta-${MY_GST_V}[opus]
		>=media-plugins/gst-plugins-srtp-${MY_GST_V}
		>=media-plugins/gst-plugins-webrtc-${MY_GST_V}
		video? (
			>=media-libs/gst-plugins-base-${MY_GST_V}[opengl]
			>=media-plugins/gst-plugins-meta-${MY_GST_V}[v4l,vpx]
			>=media-plugins/gst-plugins-qt5-${MY_GST_V}
			>=media-plugins/gst-plugins-ximagesrc-${MY_GST_V}
			x11-libs/xcb-util-wm
		)
	)
"
DEPEND="
	dev-cpp/nlohmann_json
	${RDEPEND}
"
BDEPEND="dev-qt/linguist-tools:5"

src_prepare() {
	use voip || sed -i '/^pkg_check_modules(GSTREAMER/d' CMakeLists.txt || die

	cmake_src_prepare
}
