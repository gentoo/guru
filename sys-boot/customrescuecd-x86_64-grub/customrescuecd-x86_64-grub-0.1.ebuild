# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Grub menu entries for the .iso image of customrescuecd"
HOMEPAGE="https://sourceforge.net/projects/customrescuecd/"

S="${WORKDIR}"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64"

RDEPEND="app-admin/customrescuecd-x86_64
	sys-boot/grub"

src_install() {
	exeinto /etc/grub.d
	newexe "${FILESDIR}"/customrescuecd.grub 39_customrescuecd

	insinto /etc/default
	newins "${FILESDIR}"/customrescuecd.default customrescuecd
}

pkg_postinst() {
	elog "To add the menu entries for customrescuecd to grub, you should now run"
	elog "	grub-mkconfig -o /boot/grub/grub.cfg"
	elog "You can set custom bootoptions in /etc/default/customrescuecd"
}
