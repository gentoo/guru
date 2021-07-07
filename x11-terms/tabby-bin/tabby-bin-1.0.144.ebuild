# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

MY_P="tabby-${PV}-linux"

DESCRIPTION="A terminal for a more modern age"
HOMEPAGE="https://eugeny.github.io/tabby"
SRC_URI="
	https://github.com/Eugeny/tabby/releases/download/v${PV}/${MY_P}.tar.gz
	https://github.com/scardracs/icons/releases/download/release/tabby-icons.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${MY_P}"

DEPEND="
	app-accessibility/at-spi2-atk
	app-accessibility/at-spi2-core
	dev-libs/atk
	dev-libs/nss
	media-libs/alsa-lib
	net-print/cups
	media-libs/mesa
	x11-libs/gdk-pixbuf
	x11-libs/gtk+
	x11-libs/libdrm
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libxshmfence
	x11-libs/pango
"

QA_PREBUILT="/opt/${PN}/*"

src_prepare(){
	default
}

src_install(){
	insinto /opt/"${PN}"
	doins -r "${S}"/*
	dosym ../../opt/"${PN}"/tabby "${EPREFIX}"/usr/bin/tabby
	fperms +x /opt/"${PN}"/tabby
	make_desktop_entry "/opt/${PN}/tabby %U" "Tabby" "tabby" \
		"GNOME;GTK;Utility;" \
		"GenericName=Tabby\n\nStartupNotify=true\nStartupWMClass=tabby"
	doicon ../tabby.svg
	doicon ../tabby.ico
	for i in {16,24,32,48,64,72,96,128,512}; do
		doicon -s "${i}" ../tabby-"${i}".png
	done
}
