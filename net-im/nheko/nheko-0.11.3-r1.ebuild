# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature xdg

MY_P="${PN}-v${PV}"
DESCRIPTION="Desktop client for the Matrix protocol"
HOMEPAGE="https://nheko-reborn.github.io/"
SRC_URI="https://nheko.im/nheko-reborn/${PN}/-/archive/v${PV}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X tiff video voip webp"
REQUIRED_USE="video? ( voip )"

MY_GST_V="1.18"
COMMON_DEPEND="
	app-text/cmark:=
	>=dev-cpp/blurhash-0.2.0:=
	dev-cpp/cpp-httplib:=[ssl]
	dev-db/lmdb:=
	dev-libs/libfmt:=
	>=dev-libs/mtxclient-0.9.0:=
	dev-libs/olm
	>=dev-libs/qtkeychain-0.12.0:=[qt5]
	dev-libs/spdlog:=
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5[widgets]
	dev-qt/qtgui:5[png]
	dev-qt/qtmultimedia:5[qml]
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	voip? (
		dev-libs/glib:2
		>=media-libs/gst-plugins-bad-${MY_GST_V}:1.0
		>=media-libs/gst-plugins-base-${MY_GST_V}:1.0
		>=media-libs/gstreamer-${MY_GST_V}:1.0
		video? (
			X? (
				x11-libs/libxcb:=
				x11-libs/xcb-util-wm
			)
		)
	)
"
# 'dev-qt/qtconcurrent' is linked but never used
DEPEND="${COMMON_DEPEND}
	dev-cpp/nlohmann_json
	>=dev-db/lmdb++-1.0.0
	dev-qt/qtconcurrent:5
"
RDEPEND="${COMMON_DEPEND}
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtquickcontrols2:5
	tiff? ( dev-qt/qtimageformats:5 )
	voip? (
		>=media-plugins/gst-plugins-dtls-${MY_GST_V}:1.0
		media-plugins/gst-plugins-libnice:1.0
		>=media-plugins/gst-plugins-meta-${MY_GST_V}:1.0[opus]
		>=media-plugins/gst-plugins-srtp-${MY_GST_V}:1.0
		>=media-plugins/gst-plugins-webrtc-${MY_GST_V}:1.0
		video? (
			>=media-libs/gst-plugins-base-${MY_GST_V}:1.0[opengl]
			>=media-plugins/gst-plugins-meta-${MY_GST_V}:1.0[vpx]
			>=media-plugins/gst-plugins-qt5-${MY_GST_V}:1.0
			X? (
				>=media-plugins/gst-plugins-ximagesrc-${MY_GST_V}:1.0
			)
		)
	)
	webp? ( dev-qt/qtimageformats:5 )
"
BDEPEND="
	dev-qt/linguist-tools:5
	|| (
		app-text/asciidoc
		dev-ruby/asciidoctor
	)
"

PATCHES=(
	"${FILESDIR}"/${P}-fix-explicit-optional-construction.patch
	"${FILESDIR}"/${P}-fix-build-against-fmt10.patch
)

src_configure() {
	local -a mycmakeargs=(
		-DSCREENSHARE_X11=$(if use video && use X; then echo ON; else echo OFF; fi)
		-DVOIP=$(usex voip)
		-DUSE_BUNDLED_CPPHTTPLIB=OFF
		-DUSE_BUNDLED_BLURHASH=OFF
	)

	cmake_src_configure
}

pkg_postinst() {
	optfeature "additional image formats support" kde-frameworks/kimageformats:5
	optfeature "audio & video file playback support" media-plugins/gst-plugins-meta[ffmpeg]
	optfeature "identicons support" dev-cpp/qt-jdenticon

	xdg_pkg_postinst
}
