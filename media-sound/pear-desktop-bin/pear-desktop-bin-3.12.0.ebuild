# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

MY_PN="youtube-music"

DESCRIPTION="Pear 🍐 is extension for music player"
HOMEPAGE="https://github.com/pear-devs/pear-desktop"
SRC_URI="
	amd64? (
		https://github.com/pear-devs/pear-desktop/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb
	)
"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret
	dev-libs/nss
	x11-misc/xdg-utils
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libXtst
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	virtual/udev
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/pango
"

QA_PREBUILT="/opt/${MY_PN}"

src_prepare() {
	default

	sed -i 's/\/opt\/YouTube Music/\/opt\/'${MY_PN}'/' usr/share/applications/com.github.th-ch."${MY_PN}".desktop || die
}

src_install() {
	local destdir="/opt/${MY_PN}"

	exeinto "${destdir}"
	doexe "opt/YouTube Music/${MY_PN}"
	doexe "opt/YouTube Music/chrome_crashpad_handler"

	insinto "${destdir}"
	doins opt/"YouTube Music"/*.bin
	doins opt/"YouTube Music"/*.pak
	doins opt/"YouTube Music"/*.so

	doins "opt/YouTube Music/icudtl.dat"

	doins -r "opt/YouTube Music/locales"
	doins -r "opt/YouTube Music/resources"

	dosym ../../opt/"${MY_PN}"/"${MY_PN}" /usr/bin/"${PN}"

	local x
	for x in 16 24 32 48 64 128 256 512 1024; do
		doicon -s ${x} usr/share/icons/hicolor/${x}*/*
	done

	domenu usr/share/applications/com.github.th-ch."${MY_PN}".desktop
}
