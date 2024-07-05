# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="The Mullvad Browser is developed to minimize tracking and fingerprinting."
HOMEPAGE="https://github.com/mullvad/mullvad-browser https://mullvad.net/"
SRC_URI="amd64? ( https://github.com/mullvad/mullvad-browser/releases/download/${PV}/mullvad-browser-linux-x86_64-${PV}.tar.xz )"

S="${WORKDIR}"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="wayland +X"

RESTRICT="bindist mirror test strip"

RDEPEND="
	app-accessibility/at-spi2-core
	app-misc/mime-types
	app-shells/bash
	dev-libs/dbus-glib
	dev-libs/glib
	dev-libs/nspr
	dev-libs/nss
	gui-libs/gtk
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-video/ffmpeg
	sys-apps/dbus
	x11-libs/cairo
	x11-themes/hicolor-icon-theme
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXtst
	wayland? (
		sys-apps/xdg-desktop-portal
	)"

QA_PREBUILT="*"

src_install() {
	# Install profiles to home dir
	touch "${S}"/mullvad-browser/Browser/is-packaged-app

	# Fix desktop file vars
	sed -i "s|Name=.*|Name=Mullvad Browser|g" "${S}"/mullvad-browser/start-mullvad-browser.desktop
	sed -i "s|Exec=.*|Exec=/opt/mullvad-browser/Browser/start-mullvad-browser --detach|g" "${S}"/mullvad-browser/start-mullvad-browser.desktop
	sed -i "s|Icon=.*|Icon=mullvad-browser|g" "${S}"/mullvad-browser/start-mullvad-browser.desktop

	# Install shim for X11. Browser doesn't seem to launch without it, see upstream issue:
	# https://gitlab.torproject.org/tpo/applications/tor-browser-build/-/issues/40565
	#
	# The X11 shim below does not affect the browser's fingerprint or functionality.
	if use X ; then
		echo "#include <stdlib.h>
		      void gdk_wayland_display_get_wl_compositor() { abort(); }
		      void gdk_wayland_device_get_wl_pointer() { abort(); }
		      void gdk_wayland_window_get_wl_surface() { abort(); }
		      void gdk_wayland_display_get_wl_display() { abort(); }" > "${S}"/X11shim.c
		cc -shared -o "${S}"/mullvad-browser/X11shim.so "${S}"/X11shim.c
		sed -i '1iexport LD_PRELOAD=/opt/mullvad-browser/X11shim.so' "${S}"/mullvad-browser/Browser/start-mullvad-browser
	fi

	insinto /opt/
	doins -r "${S}"/mullvad-browser

	dosym "../../opt/mullvad-browser/Browser/start-mullvad-browser" /usr/bin/${PN}
	domenu "${S}"/mullvad-browser/start-mullvad-browser.desktop
	local x
	for x in 16 32 48 64 128; do
		newicon -s ${x} "${S}"/mullvad-browser/Browser/browser/chrome/icons/default/default${x}.png mullvad-browser.png
	done

	fperms +x "/opt/mullvad-browser/Browser/start-mullvad-browser"
	fperms +x "/opt/mullvad-browser/Browser/mullvadbrowser"
	fperms +x "/opt/mullvad-browser/Browser/mullvadbrowser.real"
}
