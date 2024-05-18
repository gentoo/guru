# Copyright 2020-2024 Gentoo Authors
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
IUSE="X +pie video voip"
REQUIRED_USE="video? ( voip )"

MY_GST_V="1.18"
RDEPEND="
	app-text/cmark:=
	dev-cpp/cpp-httplib:=
	dev-db/lmdb:=
	>=dev-db/lmdb++-1.0.0
	dev-libs/libevent:=
	dev-libs/libfmt:=
	dev-libs/olm
	>=dev-libs/openssl-1.1.0:=
	>=dev-libs/qtkeychain-0.14.1-r1:=[qt6]
	>=dev-libs/re2-0.2022.04.01:=
	dev-libs/spdlog:=
	>=dev-qt/kdsingleapplication-1.1.0:=[qt6]
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
# TODO: gst-plugins-qt6
DEPEND="
	dev-cpp/nlohmann_json
	${RDEPEND}
"
BDEPEND="
	dev-qt/qttools:6[linguist]
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
		-DX11=$(usex X)
	)

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
		"dev-libs/qtkeychain[keyring]"
	optfeature "additional, less common, image format support" \
		"kde-frameworks/kimageformats:6"
	optfeature "identicons support" dev-cpp/qt-jdenticon:6

	xdg_pkg_postinst

	ewarn "since Nheko migrated to Qt 6 there may be some regressions. video streams will"
	ewarn "probably not work for now. d95d2fcaa9e3b8ab47275d2bf56e5a7ebddd37e7 was the"
	ewarn "last commit with Qt5 support."
}
