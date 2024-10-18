# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="YouTube Music Desktop App bundled with custom plugins"
HOMEPAGE="https://th-ch.github.io/youtube-music/"
SRC_URI="https://github.com/th-ch/youtube-music/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb"

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
	x11-libs/cairo
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

RESTRICT="mirror strip"

QA_PREBUILT="
	opt/${MY_PN}/chrome-sandbox
	opt/${MY_PN}/chrome_crashpad_handler
	opt/${MY_PN}/libEGL.so
	opt/${MY_PN}/libffmpeg.so
	opt/${MY_PN}/libGLESv2.so
	opt/${MY_PN}/libvk_swiftshader.so
	opt/${MY_PN}/libvulkan.so.1
	opt/${MY_PN}/${MY_PN}
"

src_prepare() {
	default

	sed -i 's/\/opt\/YouTube Music/\/opt\/'${MY_PN}'/' usr/share/applications/"${MY_PN}".desktop || die
}

src_install() {
	insinto /opt/"${MY_PN}"
	doins -r opt/"YouTube Music"/*

	insinto /usr/share
	doins -r usr/share/icons

	domenu usr/share/applications/"${MY_PN}".desktop

	local f
	for f in ${QA_PREBUILT}; do
		fperms +x "/${f}"
	done

	fperms u+s /opt/"${MY_PN}"/chrome-sandbox
}
