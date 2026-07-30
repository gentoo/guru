# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Visualisation for Electronic and STructural Analysis"

HOMEPAGE="https://jp-minerals.org/vesta/en/"

SRC_URI="https://jp-minerals.org/vesta/archives/${PV}/VESTA-gtk3.tar.bz2"

S="${WORKDIR}/VESTA-gtk3"

LICENSE="VESTA"

SLOT="0"

KEYWORDS="~amd64"

# As of 3.5.6, wayland support required for gtk even when running on xorg.
RDEPEND="app-accessibility/at-spi2-core:2
	dev-libs/glib:2
	media-libs/fontconfig:1.0
	media-libs/libglvnd
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.10:2
	>=x11-libs/gtk+-3.22:3[wayland]
	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXxf86vm
	x11-libs/pango
	virtual/glu
	>=virtual/jre-1.4.1"

RESTRICT="mirror strip"

QA_PREBUILT="opt/VESTA/*"

src_install() {
	insinto /opt/VESTA
	doins -r "${S}"/*

	fperms +x /opt/VESTA/VESTA
	fperms +x /opt/VESTA/VESTA-gui

	newicon -s 128x128 img/logo.png VESTA.png
	newicon -s 256x256 img/logo@2x.png VESTA.png

	make_desktop_entry "/opt/VESTA/VESTA" \
					   "VESTA" \
					   "VESTA" \
					   "Science;"

	dosym -r /opt/VESTA/libVESTA.so /usr/lib64/libVESTA.so
}
