# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

MY_PN="${PN%-bin}"
MY_P="${MY_PN}_${PV}"
DESCRIPTION="Axolotl is a cross-platform Signal client"
HOMEPAGE="
	https://axolotl.chat/
	https://github.com/nanu-c/axolotl
"
RELEASE_URI="https://github.com/nanu-c/${MY_PN}/releases/download/v${PV}"
SRC_URI="
	amd64? ( ${RELEASE_URI}/${MY_P}_amd64.deb )
	arm64? ( ${RELEASE_URI}/${MY_P}-1_arm64.deb )
"
S="${WORKDIR}"

LICENSE="GPL-3"
LICENSE+="
	|| ( 0BSD Apache-2.0 MIT )
	|| ( Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT )
	|| ( Apache-2.0 BSD MIT )
	|| ( Apache-2.0 Boost-1.0 )
	|| ( Apache-2.0 ISC MIT )
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 MIT ZLIB )
	|| ( MIT Unlicense )
	AGPL-3 Apache-2.0 BSD BSD-2 CC-BY-4.0 CC0-1.0 GPL-3+ ISC LGPL-3 MIT UbuntuFontLicense-1.0 Unicode-DFS-2016 openssl
"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="
	dev-libs/glib:2
	net-libs/libsoup:3.0
	net-libs/webkit-gtk:4.1
	sys-libs/glibc
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/cairo[glib]
	x11-libs/pango
"

QA_PREBUILT="usr/bin/axolotl"

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker
}
