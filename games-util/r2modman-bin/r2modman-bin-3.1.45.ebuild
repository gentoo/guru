# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

M_PN=r2modman

inherit desktop xdg
SRC_URI="https://github.com/ebkr/${M_PN}Plus/releases/download/v${PV}/${M_PN}-${PV}.tar.gz -> ${P}.tar.gz"
DESCRIPTION="A simple and easy to use mod manager for several games using Thunderstore"
HOMEPAGE="https://github.com/ebkr/r2modmanPlus"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${M_PN}-${PV}"

src_install() {
	## Install binaries file
	cp -r "${S}" "${WORKDIR}/${M_PN}" #Fix folder name
	insinto /opt
	doins -r "${WORKDIR}/${M_PN}"
	fperms 755 "/opt/${M_PN}/r2modman"

	## Install desktop and icon file
	# Copy and fix version on desktop file version
	domenu "${FILESDIR}/${M_PN}".desktop
	sed -i 's/Version=pkgversion/Version='${PV}'/g' "${D}/usr/share/applications/${M_PN}".desktop
	sed -i 's/X-AppImage-Version=pkgversion/X-AppImage-Version='${PV}'/g' "${D}/usr/share/applications/${M_PN}".desktop

	# Install icons
	newicon -s 16 "${FILESDIR}/${M_PN}"-16x16.png "${M_PN}".png
	newicon -s 32 "${FILESDIR}/${M_PN}"-32x32.png "${M_PN}".png
	newicon -s 48 "${FILESDIR}/${M_PN}"-48x48.png "${M_PN}".png
	newicon -s 64 "${FILESDIR}/${M_PN}"-64x64.png "${M_PN}".png
	newicon -s 96 "${FILESDIR}/${M_PN}"-96x96.png "${M_PN}".png
	newicon -s 128 "${FILESDIR}/${M_PN}"-128x128.png "${M_PN}".png
	newicon -s 192 "${FILESDIR}/${M_PN}"-192x192.png "${M_PN}".png
	newicon -s 256 "${FILESDIR}/${M_PN}"-256x256.png "${M_PN}".png
}

pkg_postinst() {
	xdg_desktop_database_update
}
