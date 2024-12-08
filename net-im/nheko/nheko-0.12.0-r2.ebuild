# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature xdg

MY_P="${PN}-v${PV}"
DESCRIPTION="Native desktop client for Matrix using Qt"
HOMEPAGE="https://github.com/Nheko-Reborn/nheko"
SRC_URI="https://nheko.im/nheko-reborn/${PN}/-/archive/v${PV}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X doc +pie man video voip wayland"
REQUIRED_USE="video? ( voip )"

# Check WebRTCSession::havePlugins() in ./src/voip/WebRTCSession.cpp
# to get GStreamer plugin deps right.
MY_GST_V="1.20.0"

QTMIN="6.5.0"
COMMON_DEPEND="
	app-text/cmark:=
	>=dev-cpp/blurhash-0.2.0:=
	dev-cpp/cpp-httplib:=
	dev-db/lmdb:=
	dev-libs/libfmt:=
	>=dev-libs/kdsingleapplication-1.1.0
	>=dev-libs/mtxclient-0.10.0:=
	dev-libs/olm
	>=dev-libs/qtkeychain-0.14.1-r1:=[qt6]
	dev-libs/spdlog:=
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6=
	>=dev-qt/qtmultimedia-${QTMIN}:6[qml]
	>=dev-qt/qtsvg-${QTMIN}:6
	X? (
		x11-libs/libxcb:=
		x11-libs/xcb-util-wm
	)
	voip? (
		>=media-libs/gstreamer-${MY_GST_V}:1.0
		>=media-libs/gst-plugins-bad-${MY_GST_V}:1.0[wayland?]
		>=media-libs/gst-plugins-base-${MY_GST_V}:1.0[X?,opengl]
	)
"
# Dependencies which are required by CMake but not linked with Nheko
INDIRECT_DEPEND="
	>=dev-cpp/coeurl-0.3.0
	dev-libs/libevent
	dev-libs/openssl
	dev-libs/re2
	net-misc/curl
"
DEPEND="
	${COMMON_DEPEND}
	${INDIRECT_DEPEND}
	dev-cpp/nlohmann_json
	>=dev-db/lmdb++-1.0.0
"
RDEPEND="
	${COMMON_DEPEND}
	dev-qt/qtimageformats:6
	virtual/notification-daemon
	voip? (
		>=media-plugins/gst-plugins-dtls-${MY_GST_V}:1.0
		media-plugins/gst-plugins-libnice:1.0
		>=media-plugins/gst-plugins-meta-${MY_GST_V}:1.0[opus]
		>=media-plugins/gst-plugins-srtp-${MY_GST_V}:1.0
		>=media-plugins/gst-plugins-webrtc-${MY_GST_V}:1.0
		video? (
			>=media-plugins/gst-plugins-meta-${MY_GST_V}:1.0[vpx]
			>=media-plugins/gst-plugins-qt6-${MY_GST_V}:1.0
			X? (
				>=media-plugins/gst-plugins-ximagesrc-${MY_GST_V}:1.0
			)
			wayland? (
				media-video/pipewire[gstreamer]
			)
		)
	)
"
BDEPEND="
	>=dev-qt/qttools-${QTMIN}:6[linguist]
	virtual/pkgconfig
	doc? ( app-text/doxygen[dot] )
	man? (
		|| (
			app-text/asciidoc
			dev-ruby/asciidoctor
		)
	)
"

PATCHES=(
	"${FILESDIR}"/${PN}-0.12.0-disable-http3.patch
	"${FILESDIR}"/${PN}-0.12.0-fmt11.patch
	"${FILESDIR}"/${PN}-0.12.0-remove-wayland-dep-on-x11.patch
)

src_configure() {
	local -a mycmakeargs=(
		-DUSE_BUNDLED_CPPHTTPLIB=no
		-DUSE_BUNDLED_BLURHASH=no

		-DVOIP=$(usex voip)
		-DX11=$(usex X)
		-DBUILD_DOCS=$(usex doc)
		-DMAN=$(usex man)

		# See #890903 and #911111
		-DCMAKE_POSITION_INDEPENDENT_CODE=$(usex pie)
	)

	cmake_src_configure
}

pkg_postinst() {
	optfeature "secrets storage support other than kwallet (for example gnome-keyring or keepassxc)" \
		"dev-libs/qtkeychain[keyring]"
	optfeature "additional, less common, image format support" \
		kde-frameworks/kimageformats:6
	optfeature "identicons support" dev-cpp/qt-jdenticon:6

	xdg_pkg_postinst
}
