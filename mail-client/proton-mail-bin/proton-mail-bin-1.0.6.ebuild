# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm xdg-utils

MY_PN="${PN%-bin}"

DESCRIPTION="Beta Client for Proton Mail"
HOMEPAGE="https://proton.me/mail"
SRC_URI="https://github.com/ProtonMail/inbox-desktop/releases/download/${PV}/${MY_PN}-${PV}-1.x86_64.rpm"
S="${WORKDIR}"

# https://github.com/NixOS/nixpkgs/pull/296127#discussion_r1528184212
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
"

QA_PREBUILT="opt/proton-mail/*"

src_install() {
	into /opt
	cp -r "${S}"/usr/lib/* "${D}"/opt/proton-mail || die "Failed to copy files to destination directory"

	dosym "../../opt/proton-mail/Proton Mail Beta" "/usr/bin/proton-mail"

	insinto /usr/share
	doins -r "${S}/usr/share/pixmaps"
	doins -r "${S}/usr/share/applications"

}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
