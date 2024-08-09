# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Betterbird is a fine-tuned version of Mozilla Thunderbird."
HOMEPAGE="https://github.com/Betterbird/thunderbird-patches https://betterbird.eu/"
SRC_URI="https://www.betterbird.eu/downloads/LinuxArchive/betterbird-${PV}-bb31.en-US.linux-x86_64.tar.bz2"

S="${WORKDIR}"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="bindist mirror test strip"

RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/dbus-glib
	dev-libs/glib
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	sys-apps/dbus
	virtual/freedesktop-icon-theme
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libxcb
	x11-libs/pango
"

QA_PREBUILT="*"

src_install() {
	insinto /opt/
	doins -r "${S}"/betterbird

	dosym "../../opt/betterbird/betterbird-bin" /usr/bin/betterbird-bin
	domenu "${FILESDIR}"/betterbird-bin.desktop
	local x
	for x in 16 32 48 64 128 256; do
		newicon -s ${x} "${S}"/betterbird/chrome/icons/default/default${x}.png betterbird.png
	done

	fperms +x "/opt/betterbird/betterbird-bin"
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "Language pack XPIs need to be downloaded and installed manually."
	elog "Please see the link below for further information."
	elog ""
	elog "\thttps://betterbird.eu/downloads/index.php"
}
