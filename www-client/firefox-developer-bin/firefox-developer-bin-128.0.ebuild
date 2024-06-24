# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

REVISION=b6

inherit desktop xdg

DESCRIPTION="Firefox browser developer edition"
HOMEPAGE="https://www.mozilla.org/en-US/firefox/developer/"
SRC_URI="https://download-installer.cdn.mozilla.net/pub/devedition/releases/${PV}${REVISION}/linux-x86_64/en-US/firefox-${PV}${REVISION}.tar.bz2
	-> ${P}-${REVISION}.tar.bz2"
S="${WORKDIR}"

LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0/developer"
KEYWORDS="~amd64"
RESTRICT="strip"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	>=dev-libs/glib-2.26:2
	>=media-libs/freetype-2.4.10
	>=x11-libs/pango-1.22.0
	media-libs/fontconfig
	sys-apps/dbus
	x11-libs/gtk+:3
"

QA_PREBUILT=".*"

src_prepare() {
	default

	cd firefox || die
	rm updater || die
}

src_install() {
	dodir "/opt/${PN}"
	cp -r firefox/. "${ED}/opt/${PN}" || die

	dosym -r "/opt/${PN}/firefox-bin" "/usr/bin/${PN}"
	make_desktop_entry "${PN}" "Firefox Developer" "${PN}" "Network;WebBrowser"
}
