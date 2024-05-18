# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MY_P="tabby-${PV}-linux"

DESCRIPTION="A terminal for a more modern age"
HOMEPAGE="https://tabby.sh"
SRC_URI="
	amd64? ( https://github.com/Eugeny/tabby/releases/download/v${PV}/${MY_P}-x64.tar.gz )
	arm? ( https://github.com/Eugeny/tabby/releases/download/v${PV}/${MY_P}-armhf.tar.gz )
"

# This needs to be adjusted to allow for arm
S="${WORKDIR}/${MY_P}-x64"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"

DEPEND="
	|| (
		>=app-accessibility/at-spi2-core-2.46.0:2
		( app-accessibility/at-spi2-atk dev-libs/atk )
	)
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
	# No icons for now
	#doicon ../tabby.svg
	#doicon ../tabby.ico
	#for i in {16,24,32,48,64,72,96,128,512}; do
	#	doicon -s "${i}" ../tabby-"${i}".png
	#done
}
