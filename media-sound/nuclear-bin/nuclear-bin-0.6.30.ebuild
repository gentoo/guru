# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit desktop xdg

MY_P="nuclear-v${PV}"

DESCRIPTION="Nuclear is a streaming program that pulls content from free sources on internet"
HOMEPAGE="https://nuclear.js.org https://github.com/nukeop/nuclear"
SRC_URI="https://github.com/nukeop/nuclear/releases/download/v${PV}/${MY_P}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	dev-libs/expat
	dev-libs/glib
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa[opengl]
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo[X]
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[X]
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
	x11-libs/pango[X]
"

QA_PREBUILT="*"

QA_PRESTRIPPED="opt/nuclear-bin/resources/bin/fpcalc"

src_install(){
	insinto /opt/"${PN}"
	doins -r "${S}"/*
	dosym -r /opt/"${PN}"/nuclear "${EPREFIX}"/usr/bin/nuclear

	fperms +x /opt/"${PN}"/nuclear
	fperms +x /opt/"${PN}"/chrome-sandbox
	fperms +x /opt/"${PN}"/resources/bin/fpcalc

	make_desktop_entry "/opt/${PN}/nuclear %U" "Nuclear" "nuclear" \
		"Audio;Music;Player;AudioVideo;" \
		"GenericName=Nuclear-bin\nStartupNotify=true\nStartupWMClass=nuclear"

	cd "${S}"/resources/media/ || die
	mv icon.icns nuclear.icns || die
	doicon nuclear.icns

	cd presskit/icons/color || die
	for i in {16,24,32,48,64,96,128,256,512}; do
		mv "${i}".png nuclear-"${i}".png || die
		doicon -s "${i}" nuclear-"${i}".png
	done

	cd ../scalable || die
	mv nuclear-icon.svg nuclear.svg || die
	doicon nuclear.svg
}
