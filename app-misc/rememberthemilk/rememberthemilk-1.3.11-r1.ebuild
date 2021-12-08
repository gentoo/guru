# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop rpm wrapper

DESCRIPTION="Freemium simple to-do tasks manager"
HOMEPAGE="https://www.rememberthemilk.com"
SRC_URI="https://www.${PN}.com/download/linux/fedora/21/x86_64/${P}-1.x86_64.rpm"

S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"
QA_PREBUILD="*"

RDEPEND="
	app-accessibility/at-spi2-atk
	app-accessibility/at-spi2-core
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	media-video/ffmpeg[chromium]
	net-print/cups
	sys-apps/dbus
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
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pango
"

QA_FLAGS_IGNORED="/opt/rememberthemilk/.*"

src_install() {
	insinto "/opt/${PN}"
	doins -r opt/RememberTheMilk/{*.pak,*.dat,locales,resources,*.bin,swiftshader,*.json}
	exeinto "/opt/${PN}"
	doexe "opt/RememberTheMilk/${PN}"

	make_wrapper "${PN}" "/opt/${PN}/${PN}" "/opt/${PN}" "/usr/$(get_libdir)/chromium"

	doicon "usr/share/pixmaps/${PN}.png"
	make_desktop_entry "${PN} %U" "Remember The Milk" "${PN}" "Office"
}
