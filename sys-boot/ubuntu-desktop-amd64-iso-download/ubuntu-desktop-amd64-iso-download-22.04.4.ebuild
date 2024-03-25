# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Downloaded from Yandex mirror (Russia), to /opt/distribs/ - no other actions"
HOMEPAGE="https://ubuntu.com/download/desktop"

f="ubuntu-$PV-desktop-amd64.iso"
SRC_URI="https://mirror.yandex.ru/ubuntu-releases/$PV/$f"
# TODO how to choose the closest/fastest mirror?

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
PROPERTIES="live"
RESTRICT="strip"
QA_PREBUILT="*"

src_install() {

	cd "$DISTDIR"

	mkdir -p "$ED/opt/distribs/" || die

	cp $f "$ED/opt/distribs/" || die
}

pkg_postinst() {
	einfo "To write to USB we have many options, but the simplest one without installing any software:"
	einfo "sudo cp $f /dev/sdX"
	einfo "it will override the data on USB"
	einfo "Instead of sdX - choose the letter of your USB flash from lsblk"
	einfo ""
	einfo "or"
	einfo "sudo dd if=$f of=/dev/sdX"
	einfo "With dd you can press Ctrl-T to see the progress"
	einfo ""
	einfo "or"
	einfo "sys-boot/ventoy-bin"
	einfo "(just copy the iso to the usb, with optional persistence storage)"
	einfo ""
	einfo "or"
	einfo "sys-boot/mkusb"
	einfo ""
	einfo "or"
	einfo "or Rufus on Windows (also with optional persistence) https://rufus.ie"
	einfo "See related documentation https://wiki.gentoo.org/wiki/LiveUSB"
	einfo ""
	einfo "ISO is saved to /opt/distribs/"
}
