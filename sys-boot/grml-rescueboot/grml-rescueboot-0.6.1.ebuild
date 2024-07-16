# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="grub2 script to add ISO images to the grub2 boot menu"
HOMEPAGE="https://wiki.grml.org/doku.php?id=rescueboot"

SRC_URI="https://raw.github.com/grml/grml-rescueboot/master/etc/default/grml-rescueboot
	https://raw.github.com/grml/grml-rescueboot/master/42_grml
"

S="${DISTDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sys-boot/grub
"

src_install() {
	insinto /etc/default/
	doins grml-rescueboot

	exeinto /etc/grub.d/
	newexe 42_grml 42_grml
}

pkg_postinst() {
	einfo "Default folder for ISOs is /boot/grml/"
	einfo "You can change it in /etc/default/grml-rescueboot"
	einfo "Put some ISOs to the folder,"
	einfo "mount your /boot:"
	einfo "mount /dev/sda1 /boot/"
	einfo "and run"
	einfo "grub-mkconfig -o /boot/grub/grub.cfg"
	einfo "Not all ISOs are bootable this way"
	einfo "Works for Ubuntu, Debian (not all ISOs)"
	einfo "https://grml.org/download/"
	einfo "but not for Gentoo ISO, see https://bugs.gentoo.org/568464"
}
