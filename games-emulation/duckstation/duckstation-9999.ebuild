# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake desktop git-r3

DESCRIPTION="Fast Sony PlayStation (PSX) emulator"
HOMEPAGE="https://github.com/stenzek/duckstation"
EGIT_REPO_URI="https://github.com/stenzek/duckstation.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}"
EGIT_SUBMODULES=()

LICENSE="GPL-3"
SLOT="0"
IUSE="+dbus discord +egl +evdev fbdev +gamepad gbm +nogui qt6 retroachievements wayland X"

# Either or both frontends must be built
REQUIRED_USE="
	?? ( fbdev gbm )
	gbm? ( egl )
	wayland? ( egl )
"

BDEPEND="
	virtual/pkgconfig
	wayland? ( kde-frameworks/extra-cmake-modules )
"
DEPEND="
	media-libs/cubeb
	evdev? ( dev-libs/libevdev )
	dbus? ( sys-apps/dbus )
	gamepad? ( >=media-libs/libsdl2-2.28.5 )
	gbm? ( x11-libs/libdrm )
	qt6? (
		dev-qt/qtbase:6[gui,network,widgets]
		dev-qt/qttools:6[linguist]
	)
	retroachievements? ( net-misc/curl[curl_ssl_gnutls] )
	X? (
			x11-libs/libX11
			x11-libs/libXrandr
	)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_CUBEB=ON
		-DBUILD_NOGUI_FRONTEND=$(usex nogui)
		-DBUILD_QT_FRONTEND=$(usex qt6)
		-DENABLE_CHEEVOS=$(usex retroachievements)
		-DENABLE_DISCORD_PRESENCE=$(usex discord)
		-DUSE_DBUS=$(usex dbus)
		-DUSE_DRMKMS=$(usex gbm)
		-DUSE_EGL=$(usex egl)
		-DUSE_EVDEV=$(usex evdev)
		-DUSE_FBDEV=$(usex fbdev)
		-DUSE_SDL2=$(usex gamepad)
		-DUSE_WAYLAND=$(usex wayland)
		-DUSE_X11=$(usex X)
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake_src_configure
}

src_install() {
	dodoc README.md

	# Binary and resources files must be in same directory – installing in /opt
	insinto /opt/${PN}
	doins -r "${BUILD_DIR}"/bin/resources/

	if use nogui; then
		newicon "${BUILD_DIR}"/bin/resources/images/duck.png duckstation-nogui.png
		make_desktop_entry "${PN}-nogui %f" "DuckStation NoGUI" "${PN}-nogui" "Game"

		doins "${BUILD_DIR}"/bin/duckstation-nogui
		dosym ../../opt/${PN}/duckstation-nogui usr/bin/duckstation-nogui
		fperms +x /opt/${PN}/duckstation-nogui
	fi

	if use qt6; then
		newicon "${BUILD_DIR}"/bin/resources/images/duck.png duckstation-qt.png
		make_desktop_entry "${PN}-qt %f" "DuckStation Qt" "${PN}-qt" "Game"

		doins -r "${BUILD_DIR}"/bin/translations/
		doins "${BUILD_DIR}"/bin/duckstation-qt
		dosym ../../opt/${PN}/duckstation-qt usr/bin/duckstation-qt
		fperms +x /opt/${PN}/duckstation-qt
	fi
}
