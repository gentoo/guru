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

RDEPEND="
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/icu
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/nspr
	dev-libs/nss
	dev-libs/wayland
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libglvnd[X]
	media-libs/libpulse
	sys-apps/dbus
	virtual/udev
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXtst
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/xcb-util
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-renderutil
	x11-libs/xcb-util-wm
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
