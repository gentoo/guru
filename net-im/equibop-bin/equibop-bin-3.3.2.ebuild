# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

MY_PN=${PN%%-bin}
MY_PN=${MY_PN^}

DESCRIPTION="Equibop is a customizable and privacy friendly Discord desktop app"
HOMEPAGE="https://equibop.org/"

SRC_URI="
	amd64? ( https://github.com/Equicord/Equibop/releases/download/v${PV}/equibop_${PV}_amd64.deb )
	arm64? ( https://github.com/Equicord/Equibop/releases/download/v${PV}/equibop_${PV}_arm64.deb )
"
# metainfo
SRC_URI+="https://github.com/Equicord/Equibop/releases/download/v${PV}/org.equicord.equibop.metainfo.xml -> ${P}.metainfo.xml"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RESTRICT="bindist mirror strip"

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
	virtual/libudev
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
	use amd64 && unpack_deb "equibop_${PV}_amd64.deb"
	use arm64 && unpack_deb "equibop_${PV}_arm64.deb"
}

src_prepare() {
	default

	# match with symlink
	sed -i "s|^Exec=.*|Exec=/usr/bin/${PN} %U|" \
		"usr/share/applications/${MY_PN,,}.desktop" || die
}

src_install() {
	local destdir="/opt/${PN}"

	exeinto "${destdir}"
	doexe "opt/${MY_PN}/${MY_PN,,}"
	doexe "opt/${MY_PN}/chrome-sandbox"
	doexe "opt/${MY_PN}/chrome_crashpad_handler"

	insinto "${destdir}"
	doins opt/"${MY_PN}"/*.bin
	doins opt/"${MY_PN}"/*.pak
	doins opt/"${MY_PN}"/*.so

	doins "opt/${MY_PN}/icudtl.dat"

	doins -r "opt/${MY_PN}/locales"
	doins -r "opt/${MY_PN}/resources"

	fperms +x "opt/${PN}/resources/arrpc/arrpc"

	dosym ../../opt/"${PN}"/"${MY_PN,,}" /usr/bin/"${PN}"

	doicon -s scalable usr/share/icons/hicolor/scalable/apps/"${MY_PN,,}".svg

	domenu "usr/share/applications/${MY_PN,,}.desktop"

	insinto /usr/share/metainfo
	newins "${DISTDIR}/${P}.metainfo.xml" org.equicord."${MY_PN,,}".metainfo.xml
}
