# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 optfeature xdg

DESCRIPTION="Native desktop client for Matrix using Qt"
HOMEPAGE="https://github.com/Nheko-Reborn/nheko"
EGIT_REPO_URI="https://github.com/Nheko-Reborn/nheko.git"
# Nheko usually needs a very up-to-date mtxclient which usually needs a very
# up-to-date coeurl. It is impossible to automatically rebuild other live
# packages before rebuilding this, so they are bundled.
MY_DEP_URIS=(
	"https://github.com/Nheko-Reborn/mtxclient.git"
	"https://nheko.im/nheko-reborn/coeurl.git"
)

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS=""
IUSE="X +pie video voip"
REQUIRED_USE="video? ( voip )"

MY_GST_V="1.18"
RDEPEND="
	app-text/cmark:=
	dev-cpp/cpp-httplib:=
	dev-cpp/qt-jdenticon
	dev-db/lmdb:=
	>=dev-db/lmdb++-1.0.0
	dev-libs/libevent:=
	dev-libs/libfmt:=
	dev-libs/olm
	>=dev-libs/openssl-1.1.0:=
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

src_unpack() {
	# Unpack dependencies first. The commit ID of the repo used in the last call
	# to git-r3_src_unpack is stored and checked by smart-live-rebuild.
	for repo_uri in ${MY_DEP_URIS[@]}; do
		EGIT_REPO_URI="${repo_uri}" EGIT_CHECKOUT_DIR="${WORKDIR}/${repo_uri##*/}" git-r3_src_unpack
	done

	git-r3_src_unpack
}

src_prepare() {
	# Don't try to download mtxclient and coeurl.
	sed -Ei '/GIT_(REPOSITORY|TAG)/d' CMakeLists.txt || die
	sed -Ei '/GIT_(REPOSITORY|TAG)/d' ../mtxclient.git/CMakeLists.txt || die

	mkdir -p "${WORKDIR}/${P}_build/_deps" || die
	mv ../mtxclient.git "${WORKDIR}/${P}_build/_deps/matrixclient-src" || die
	mv ../coeurl.git "${WORKDIR}/${P}_build/_deps/coeurl-src" || die

	cmake_src_prepare
}

src_configure() {
	local -a mycmakeargs=(
		-DUSE_BUNDLED_MTXCLIENT=yes
		-DUSE_BUNDLED_COEURL=yes
		-DBUILD_SHARED_LIBS=no
		-DVOIP=$(usex voip)
		-DCMAKE_POSITION_INDEPENDENT_CODE=$(usex pie)
		-DUSE_BUNDLED_CPPHTTPLIB=no
	)
	if use video && use X; then
		mycmakeargs+=("-DSCREENSHARE_X11=yes")
	else
		mycmakeargs+=("-DSCREENSHARE_X11=no")
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install

	# Remove stuff from bundled libs.
	rm -r "${D}/usr/$(get_libdir)" || die
	rm -r "${D}/usr/include" || die
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
