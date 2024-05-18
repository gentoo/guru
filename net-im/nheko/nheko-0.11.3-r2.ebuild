# Copyright 2020-2024 Gentoo Authors
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
IUSE="X doc +jpeg man tiff v4l video voip +webp"
REQUIRED_USE="video? ( voip )"

MY_GST_V="1.18"
COMMON_DEPEND="
	app-text/cmark:=
	>=dev-cpp/blurhash-0.2.0:=
	dev-cpp/cpp-httplib:=
	dev-db/lmdb:=
	dev-libs/libfmt:=
	>=dev-libs/mtxclient-0.9.0:=
	dev-libs/olm
	>=dev-libs/qtkeychain-0.12.0:=[qt5]
	dev-libs/spdlog:=
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5[widgets]
	dev-qt/qtgui:5[jpeg?,png]
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
# 'virtual/notification-daemon' is required because of upstream bug:
# https://github.com/Nheko-Reborn/nheko/issues/693
RDEPEND="${COMMON_DEPEND}
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtquickcontrols2:5
	virtual/notification-daemon
	tiff? ( dev-qt/qtimageformats:5 )
	voip? (
		>=media-plugins/gst-plugins-dtls-${MY_GST_V}:1.0
		media-plugins/gst-plugins-libnice:1.0
		>=media-plugins/gst-plugins-meta-${MY_GST_V}:1.0[opus]
		>=media-plugins/gst-plugins-srtp-${MY_GST_V}:1.0
		>=media-plugins/gst-plugins-webrtc-${MY_GST_V}:1.0
		video? (
			>=media-libs/gst-plugins-base-${MY_GST_V}:1.0[opengl]
			>=media-plugins/gst-plugins-meta-${MY_GST_V}:1.0[v4l?,vpx]
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
	doc? ( app-text/doxygen[dot] )
	man? (
		|| (
			app-text/asciidoc
			dev-ruby/asciidoctor
		)
	)
"

PATCHES=(
	"${FILESDIR}"/${P}-fix-explicit-optional-construction.patch
	"${FILESDIR}"/${P}-fix-build-against-fmt10.patch
)

DOCS=( {CHANGELOG,README}.md )

src_configure() {
	local -a mycmakeargs=(
		-DSCREENSHARE_X11=$(if use video && use X; then echo ON; else echo OFF; fi)
		-DVOIP=$(usex voip)
		-DBUILD_DOCS=$(usex doc)
		-DMAN=$(usex man)
		-DUSE_BUNDLED_CPPHTTPLIB=OFF
		-DUSE_BUNDLED_BLURHASH=OFF

		# See #890903 and #911111
		-DCMAKE_POSITION_INDEPENDENT_CODE=OFF

		# Handle transitive dependencies
		-DOPENSSL_FOUND:BOOL=TRUE
		-Dlibevent_core_FOUND:BOOL=TRUE
		-Dlibevent_pthreads_FOUND:BOOL=TRUE
		-Dlibcurl_FOUND:BOOL=TRUE
		-Dre2_FOUND:BOOL=TRUE
	)

	use doc && HTML_DOCS=( "${BUILD_DIR}"/docs/html/. )
	cmake_src_configure
}

pkg_postinst() {
	optfeature "additional image formats support" kde-frameworks/kimageformats:5
	optfeature "audio & video file playback support" media-plugins/gst-plugins-meta[ffmpeg]
	optfeature "secrets storage support other than kwallet (for example gnome-keyring or keepassxc)" \
		"dev-libs/qtkeychain[keyring]"
	optfeature "identicons support" dev-cpp/qt-jdenticon:5

	xdg_pkg_postinst
}
