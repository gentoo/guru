# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Ubuntu based ISO to fix GRUB problems - just downloads to /opt/distribs/"
HOMEPAGE="https://sourceforge.net/p/boot-repair-cd/home/Home/"

SRC_URI="https://yer.dl.sourceforge.net/project/boot-repair-cd/boot-repair-disk-64bit.iso"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
PROPERTIES="live"
RESTRICT="strip"
QA_PREBUILT="*"

src_install() {

	cd "$DISTDIR" || die

	mkdir -p "$ED/opt/distribs/" || die

	cp boot-repair-disk-64bit.iso "$ED/opt/distribs/" || die
}

pkg_postinst() {
	einfo "To write to USB we have many options, but the simplest one without installing any software:"
	einfo "sudo cp boot-repair-disk-64bit.iso /dev/sdX"
	einfo "it will override the data on USB"
	einfo "Instead of sdX - choose the letter of your USB flash from lsblk"
	einfo "or"
	einfo "sudo dd if=boot-repair-disk-64bit.iso of=/dev/sdX"
	einfo "With dd you can press Ctrl-T to see the progress"
	einfo "or sys-boot/ventoy-bin (just copy the iso to the usb, with optional persistence storage)"
	einfo "or Rufus on Windows (also with optional persistence) https://rufus.ie"
	einfo "See related documentation https://wiki.gentoo.org/wiki/LiveUSB"
}
