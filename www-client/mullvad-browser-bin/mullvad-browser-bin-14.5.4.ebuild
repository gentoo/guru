# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature toolchain-funcs xdg

DESCRIPTION="The Mullvad Browser is developed to minimize tracking and fingerprinting."
HOMEPAGE="https://github.com/mullvad/mullvad-browser/ https://mullvad.net/"
SRC_URI="https://github.com/mullvad/mullvad-browser/releases/download/${PV}/mullvad-browser-linux-x86_64-${PV}.tar.xz -> ${P}.tar.xz"

S="${WORKDIR}"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="X"

RDEPEND="
	app-accessibility/at-spi2-core
	app-misc/mime-types
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
"

QA_PREBUILT="*"

src_install() {
	# Install profiles to home dir
	touch mullvad-browser/Browser/is-packaged-app || die

	# Fix desktop file vars
	sed -i \
		-e 's|Name=.*|Name=Mullvad Browser|g' \
		-e 's|Exec=.*|Exec=/opt/mullvad-browser/Browser/start-mullvad-browser --detach|g' \
		-e 's|Icon=.*|Icon=mullvad-browser|g' \
		mullvad-browser/start-mullvad-browser.desktop || die

	insinto /opt/
	doins -r mullvad-browser

	dosym ../../opt/mullvad-browser/Browser/start-mullvad-browser /usr/bin/${PN}
	domenu mullvad-browser/start-mullvad-browser.desktop
	local x
	for x in 16 32 48 64 128; do
		newicon -s ${x} mullvad-browser/Browser/browser/chrome/icons/default/default${x}.png mullvad-browser.png
	done

	fperms 755 /opt/mullvad-browser/Browser/abicheck
	fperms +x /opt/mullvad-browser/Browser/glxtest
	fperms +x /opt/mullvad-browser/Browser/vaapitest
	fperms +x /opt/mullvad-browser/Browser/start-mullvad-browser
	fperms +x /opt/mullvad-browser/Browser/mullvadbrowser
	fperms +x /opt/mullvad-browser/Browser/mullvadbrowser.real
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "wayland screensharing support" sys-apps/xdg-desktop-portal
}
