# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Infinite canvas drawing/whiteboarding. Made with Godot."
HOMEPAGE="https://github.com/mbrlabs/Lorien"
SRC_URI="https://github.com/mbrlabs/Lorien/releases/download/v${PV}/Lorien_v${PV}_Linux.tar.xz -> ${P}.tar.xz"

S="${WORKDIR}/Lorien_v${PV}_Linux"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	media-libs/mesa[opengl(+)]
	x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
"

# Since is a binary package
QA_PREBUILT="/opt/Lorien/Lorien.x86_64"

src_install() {
	#Copy Manual & Make a copy of the folder
	cp "${FILESDIR}/manual_v${PV}.md" "${S}/manual_v${PV}.md"
	cp -r "${S}" "${WORKDIR}/Lorien"

	#Install in /opt
	insinto /opt
	doins -r "${WORKDIR}/Lorien"
	fperms +x /opt/Lorien/Lorien.x86_64

	#Install icon and desktop file
	domenu "${FILESDIR}/lorien.desktop"
	doicon "${FILESDIR}/lorien.png"
}

pkg_postinst() {
	xdg_desktop_database_update
	ewarn "Manual of this package is hosted on the github repo: https://github.com/mbrlabs/Lorien/blob/main/docs/manuals/manual_v${PV}.md"
	ewarn "You also have a copy of the manual in /opt/Lorien/manual_v${PV}.md"
	ewarn "Note: The manual is writen in Markdown format"
}

pkg_postrm() {
	xdg_desktop_database_update
}
