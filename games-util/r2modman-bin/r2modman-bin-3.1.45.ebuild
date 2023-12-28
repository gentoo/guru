# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

M_PN=r2modman

inherit desktop xdg
SRC_URI="
	https://github.com/ebkr/${M_PN}Plus/releases/download/v${PV}/${M_PN}-${PV}.tar.gz -> ${P}.tar.gz
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/16x16.png -> "${M_PN}"-16x16.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/32x32.png -> "${M_PN}"-32x32.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/48x48.png -> "${M_PN}"-48x48.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/64x64.png -> "${M_PN}"-64x64.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/96x96.png -> "${M_PN}"-96x96.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/128x128.png -> "${M_PN}"-128x128.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/192x192.png -> "${M_PN}"-192x192.png
	https://raw.githubusercontent.com/ebkr/r2modmanPlus/v${PV}/src/assets/icon/256x256.png -> "${M_PN}"-256x256.png
"
DESCRIPTION="A simple and easy to use mod manager for several games using Thunderstore"
HOMEPAGE="https://github.com/ebkr/r2modmanPlus"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~x86"

S="${WORKDIR}"

src_install() {
	# Install binaries file
	mv "${M_PN}-${PV}" "${M_PN}" || die #Fix folder name
	insinto /opt
	doins -r "${M_PN}"
	fperms 755 "/opt/${M_PN}/r2modman"

	#Install License file in proper location
	find "${ED}" -name "LICENSE*" -delete || die

	# Install desktop file
	domenu "${FILESDIR}/${M_PN}".desktop

	# Install icons
	newicon -s 16 "${DISTDIR}/${M_PN}"-16x16.png "${M_PN}".png
	newicon -s 32 "${DISTDIR}/${M_PN}"-32x32.png "${M_PN}".png
	newicon -s 48 "${DISTDIR}/${M_PN}"-48x48.png "${M_PN}".png
	newicon -s 64 "${DISTDIR}/${M_PN}"-64x64.png "${M_PN}".png
	newicon -s 96 "${DISTDIR}/${M_PN}"-96x96.png "${M_PN}".png
	newicon -s 128 "${DISTDIR}/${M_PN}"-128x128.png "${M_PN}".png
	newicon -s 192 "${DISTDIR}/${M_PN}"-192x192.png "${M_PN}".png
	newicon -s 256 "${DISTDIR}/${M_PN}"-256x256.png "${M_PN}".png
}
