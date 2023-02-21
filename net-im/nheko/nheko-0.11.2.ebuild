# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature xdg

DESCRIPTION="Native desktop client for Matrix using Qt"
HOMEPAGE="https://github.com/Nheko-Reborn/nheko"
SRC_URI="https://github.com/Nheko-Reborn/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X +pie video voip"
REQUIRED_USE="video? ( voip )"

MY_GST_V="1.18"
RDEPEND="
	app-text/cmark:=
	>=dev-cpp/blurhash-0.2.0:=
	dev-cpp/cpp-httplib:=
	dev-cpp/qt-jdenticon
	dev-db/lmdb:=
	>=dev-db/lmdb++-1.0.0
	dev-libs/libfmt:=
	>=dev-libs/mtxclient-0.9.0:=
	>=dev-libs/qtkeychain-0.12.0:=
	>=dev-libs/re2-0.2022.04.01:=
	dev-libs/spdlog:=
	dev-qt/qtconcurrent:5
	dev-qt/qtdeclarative:5[widgets]
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtgui:5[dbus,jpeg,png]
	dev-qt/qtimageformats
	dev-qt/qtmultimedia:5[gstreamer,qml,widgets]
	dev-qt/qtquickcontrols2:5[widgets]
	dev-qt/qtsvg:5
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
			>=media-plugins/gst-plugins-qt5-${MY_GST_V}
			X? (
				>=media-plugins/gst-plugins-ximagesrc-${MY_GST_V}
				x11-libs/libxcb:=
				x11-libs/xcb-util-wm
			)
		)
	)
"
DEPEND="
	dev-cpp/nlohmann_json
	${RDEPEND}
"
BDEPEND="
	dev-qt/linguist-tools:5
	|| (
		app-text/asciidoc
		dev-ruby/asciidoctor
	)
"

src_configure() {
	local -a mycmakeargs=(
		-DVOIP=$(usex voip)
		-DCMAKE_POSITION_INDEPENDENT_CODE=$(usex pie)
		-DUSE_BUNDLED_CPPHTTPLIB=no
		-DUSE_BUNDLED_BLURHASH=no
	)
	if use video && use X; then
		mycmakeargs+=(-DSCREENSHARE_X11=yes)
	else
		mycmakeargs+=(-DSCREENSHARE_X11=no)
	fi

	cmake_src_configure
}

pkg_postinst() {
	optfeature "audio & video file playback support" \
		"media-plugins/gst-plugins-meta[ffmpeg]"
	optfeature "secrets storage support other than kwallet (for example gnome-keyring or keepassxc)" \
		"dev-libs/qtkeychain[gnome-keyring]"
	optfeature "additional, less common, image format support" \
		"kde-frameworks/kimageformats"

	xdg_pkg_postinst
}
