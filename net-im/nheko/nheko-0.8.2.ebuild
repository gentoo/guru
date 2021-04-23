# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

DESCRIPTION="Desktop client for Matrix using Qt and C++14"
HOMEPAGE="https://github.com/Nheko-Reborn/nheko"
SRC_URI="https://github.com/Nheko-Reborn/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-qt/qtmultimedia:5[gstreamer,qml]
	dev-qt/qtquickcontrols2:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtsvg:5
	dev-qt/qtconcurrent:5
	app-text/cmark
	>=dev-libs/mtxclient-0.5.1
	dev-cpp/nlohmann_json
	dev-libs/qtkeychain
"
DEPEND="
	${RDEPEND}
	dev-libs/spdlog
	>=dev-db/lmdb++-1.0.0
"
BDEPEND="dev-qt/linguist-tools:5"

src_prepare() {
	cmake_src_prepare
	xdg_src_prepare
}

# # Preparation for when gstreamer >= 1.18 lands in ::gentoo.
# MY_GSTREAMER_V="1.18"
#
#	voip? (
#		>=media-libs/gstreamer-${MY_GSTREAMER_V}
#		>=media-plugins/gst-plugins-meta-${MY_GSTREAMER_V}[opus,vpx]
#		>=media-libs/gst-plugins-base-${MY_GSTREAMER_V}[opengl]
#		>=media-libs/gst-plugins-good-${MY_GSTREAMER_V}
#		>=media-libs/gst-plugins-bad-${MY_GSTREAMER_V}
#		>=media-plugins/gst-plugins-dtls-${MY_GSTREAMER_V}
#		>=media-plugins/gst-plugins-srtp-${MY_GSTREAMER_V}
#		>=media-plugins/gst-plugins-webrtc-${MY_GSTREAMER_V}
#		net-libs/libnice
#	)
