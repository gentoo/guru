# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Visualisation for Electronic and STructural Analysis."

HOMEPAGE="https://jp-minerals.org/vesta/en/"

SRC_URI="https://jp-minerals.org/vesta/archives/${PV}/VESTA-gtk3.tar.bz2"

S="${WORKDIR}/VESTA-gtk3"

LICENSE="VESTA"

SLOT="0"

KEYWORDS="~amd64"

# As of 3.5.6, wayland support required for gtk even when running on xorg.
RDEPEND="x11-libs/gtk+:3[wayland]
	x11-libs/gtk+:2
	>=virtual/glu-9.0-r2
	>=virtual/jdk-17"

RESTRICT="strip"

QA_PREBUILT="opt/VESTA/*"

src_install() {
	insinto /opt/VESTA
	doins -r "${S}"/*
	fperms +x /opt/VESTA/VESTA
	fperms +x /opt/VESTA/VESTA-gui

	domenu "${FILESDIR}"/VESTA.desktop
	newicon -s 128x128 "${D}"/opt/VESTA/img/logo.png VESTA.png

	dosym -r /opt/VESTA/libVESTA.so /usr/lib64/libVESTA.so
}
