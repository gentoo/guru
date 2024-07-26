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
IUSE="X doc +pie +man video voip"
REQUIRED_USE="video? ( voip )"

MY_GST_V="1.18"
RDEPEND="
	app-text/cmark:=
	>=dev-cpp/blurhash-0.2.0:=
	>=dev-cpp/coeurl-0.3.1:=[ssl]
	dev-cpp/cpp-httplib:=
	dev-db/lmdb:=
	>=dev-db/lmdb++-1.0.0
	dev-libs/libevent:=
	dev-libs/libfmt:=
	>=dev-libs/kdsingleapplication-1.1.0
	>=dev-libs/mtxclient-0.10.0:=
	dev-libs/olm
	>=dev-libs/openssl-1.1.0:=
	>=dev-libs/qtkeychain-0.14.1-r1:=[qt6]
	>=dev-libs/re2-0.2022.04.01:=
	dev-libs/spdlog:=
	dev-qt/qtbase:6[concurrent,dbus,gui,widgets]
	dev-qt/qtdeclarative:6[widgets]
	dev-qt/qtimageformats:6
	dev-qt/qtmultimedia:6[gstreamer]
	dev-qt/qtsvg:6
	net-misc/curl[ssl]
	virtual/notification-daemon
	voip? (
		>=media-plugins/gst-plugins-dtls-${MY_GST_V}
		media-plugins/gst-plugins-libnice
		>=media-plugins/gst-plugins-meta-${MY_GST_V}[opus]
		>=media-plugins/gst-plugins-srtp-${MY_GST_V}
		>=media-plugins/gst-plugins-webrtc-${MY_GST_V}
		video? (
			>=media-libs/gst-plugins-base-${MY_GST_V}[opengl]
			>=media-plugins/gst-plugins-meta-${MY_GST_V}[v4l,vpx]
			X? (
				>=media-plugins/gst-plugins-ximagesrc-${MY_GST_V}
			)
		)
	)
	X? (
		x11-libs/libxcb:=
		x11-libs/xcb-util-wm
	)
"
# TODO: gst-plugins-qt6 for video calls
DEPEND="
	dev-cpp/nlohmann_json
	${RDEPEND}
"
BDEPEND="
	dev-qt/qttools:6[linguist]
	doc? ( app-text/doxygen[dot] )
	man? (
		|| (
			app-text/asciidoc
			dev-ruby/asciidoctor
		)
	)
"

PATCHES=( "${FILESDIR}"/${P}-remove-wayland-dep-on-x11.patch )

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
	optfeature "audio & video file playback support" \
		"media-plugins/gst-plugins-meta[ffmpeg]"
	optfeature "secrets storage support other than kwallet (for example gnome-keyring or keepassxc)" \
		"dev-libs/qtkeychain[keyring]"
	optfeature "additional, less common, image format support" \
		"kde-frameworks/kimageformats:6"
	optfeature "identicons support" dev-cpp/qt-jdenticon:6

	xdg_pkg_postinst

	ewarn "since Nheko migrated to Qt 6 video streams will not work for now because"
	ewarn "we are missing a dependency. see <https://bugs.gentoo.org/810814> for details"
}
