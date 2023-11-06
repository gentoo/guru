# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Cisco's packet tracer"
HOMEPAGE="https://www.netacad.com/portal/resources/packet-tracer"
SRC_URI="CiscoPacketTracer_821_Ubuntu_64bit.deb"

LICENSE="Cisco"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="fetch mirror strip"

DEPEND=""
RDEPEND="${DEPEND}
        dev-libs/icu
        x11-libs/xcb-util
"
S="${WORKDIR}"
QA_PREBUILT="opt/pt/*"

pkg_nofetch(){
	ewarn "To fetch sources, you need a Cisco account which is"
        ewarn "available if you're a web-learning student, instructor"
        ewarn "or you sale Cisco hardware, etc."
        ewarn "Go to https://www.netacad.com and login with"
        ewarn "your account,  download a file named"
        ewarn "\"${A}\" then move it to your DISTDIR directory."
	ewarn "After commpleting those steps, re-run the emerge command."
}

src_install(){
	cp -r . "${ED}"
        for icon in pka	pkt pkz; do
                newicon -s 48x48 -c mimetypes opt/pt/art/${icon}.png application-x-${icon}.png
        done
	dobin opt/pt/packettracer
}
