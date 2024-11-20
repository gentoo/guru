# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

DESCRIPTION="Revolt Desktop App"
HOMEPAGE="https://github.com/revoltchat/desktop https://revolt.chat/"
SRC_URI="
	amd64? ( https://github.com/revoltchat/desktop/releases/download/v${PV}/${P}.tar.gz -> ${P}.gh.tar.gz )
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-lang/python-exec
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-apps/systemd-utils
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb:=
	x11-libs/libxkbcommon
	x11-libs/pango
"

QA_PREBUILT="*"

DESTDIR="/opt/${PN}"

src_install() {
	exeinto "${DESTDIR}"
	doexe "${PN}" chrome-sandbox libEGL.so libffmpeg.so libGLESv2.so libvk_swiftshader.so

	ln -sf "$(command -v python3)" resources/app.asar.unpacked/node_modules/register-scheme/build/node_gyp_bins/python3 || die

	insinto "${DESTDIR}"
	doins chrome_crashpad_handler chrome_{100,200}_percent.pak icudtl.dat resources.pak snapshot_blob.bin v8_context_snapshot.bin
	insopts -m0755
	doins -r locales resources

	# Chrome-sandbox requires the setuid bit to be specifically set.
	# see https://github.com/electron/electron/issues/17972
	fowners root "${DESTDIR}/chrome-sandbox"
	fperms 4711 "${DESTDIR}/chrome-sandbox"

	make_wrapper "${PN}" "${DESTDIR}/${PN}"
	make_desktop_entry revolt-desktop Revolt "" Network
}
