# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm xdg-utils

DESCRIPTION="Beta Client for Proton Mail"
HOMEPAGE="https://proton.me/mail"
SRC_URI="https://proton.me/download/mail/linux/ProtonMail-desktop-beta.rpm -> ${P}.rpm"

S="${WORKDIR}"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
