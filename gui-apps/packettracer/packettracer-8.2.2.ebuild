# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Cisco's packet tracer"
HOMEPAGE="https://www.netacad.com/resources/lab-downloads"
SRC_URI="Packet_Tracer822_amd64_signed.deb"

S="${WORKDIR}"

LICENSE="Cisco"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch mirror strip"

RDEPEND="${DEPEND}
	dev-libs/icu
	x11-libs/xcb-util
"

QA_PREBUILT="opt/pt/*"

pkg_nofetch(){
	ewarn "To fetch sources, you need a Cisco account which is"
	ewarn "available if you're a web-learning student, instructor"
	ewarn "or you sale Cisco hardware, etc."
	ewarn "after that, go to https://www.netacad.com/resources/lab-downloads and login with"
	ewarn "your account, and after that, you should download a file"
	ewarn "named \"${A}\" then move it to"
	ewarn "your DISTDIR directory"
	ewarn "and then, you can proceed with the installation."
}

src_install(){
	cp -r . "${ED}" || die
	for icon in pka pkt pkz; do
		newicon -s 48x48 -c mimetypes opt/pt/art/${icon}.png application-x-${icon}.png
	done
	newmenu "${FILESDIR}/${PN}-${PV}.desktop" "${PN}.desktop"
	dobin opt/pt/packettracer
}
