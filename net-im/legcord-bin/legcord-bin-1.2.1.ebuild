# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

MY_PN="Legcord"

DESCRIPTION="Legcord is a custom client designed to enhance your Discord experience."
HOMEPAGE="https://legcord.app/"

SRC_URI="
	amd64? ( https://github.com/Legcord/Legcord/releases/download/v${PV}/Legcord-${PV}-linux-amd64.deb -> ${P}-amd64.deb )
	arm64? ( https://github.com/Legcord/Legcord/releases/download/v${PV}/Legcord-${PV}-linux-arm64.deb -> ${P}-arm64.deb )
"
# metainfo
SRC_URI+="https://github.com/Legcord/Legcord/releases/download/v${PV}/app.legcord.Legcord.metainfo.xml"

S="${WORKDIR}"

LICENSE="MIT BSD OSL-3.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RESTRICT="bindist mirror test strip"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gtk+:3
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

QA_PREBUILT="*"

src_unpack() {
	use amd64 && unpack_deb "${P}-amd64.deb"
	use arm64 && unpack_deb "${P}-arm64.deb"
}

src_prepare() {
	default

	# match with syslink
	sed -i "s|^Exec=.*|Exec=/usr/bin/legcord-bin %U|" \
		"usr/share/applications/${MY_PN}.desktop" || die
}

src_install() {
	DESTDIR="/opt/${PN}"

	local x
	for x in 16 32 64 128 256 512; do
		doicon -s ${x} usr/share/icons/hicolor/${x}*/*
	done

	domenu "usr/share/applications/${MY_PN}.desktop"

	insinto /usr/share/metainfo
	doins "${DISTDIR}/app.legcord.${MY_PN}.metainfo.xml"

	exeinto "${DESTDIR}"
	doexe "opt/${MY_PN}/${MY_PN}"
	doexe "opt/${MY_PN}/chrome-sandbox"
	doexe "opt/${MY_PN}/chrome_crashpad_handler"

	insinto "${DESTDIR}"
	doins opt/"${MY_PN}"/*.bin
	doins opt/"${MY_PN}"/*.pak
	doins opt/"${MY_PN}"/*.so

	doins "opt/${MY_PN}/icudtl.dat"

	doins -r "opt/${MY_PN}/locales"
	doins -r "opt/${MY_PN}/resources"

	dosym ../../opt/"${PN}"/"${MY_PN}" /usr/bin/"${PN}"
}
