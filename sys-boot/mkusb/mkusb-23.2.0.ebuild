# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg-utils

DESCRIPTION="CLI and GUI for creating bootable live USB, with optional persistent storage"
HOMEPAGE="https://help.ubuntu.com/community/mkusb"
SRC_URI="
	https://launchpad.net/~$PN/+archive/ubuntu/ppa/+files/$PN-common_$PV-1ubuntu1_all.deb -> $P-common.deb
	https://launchpad.net/~$PN/+archive/ubuntu/unstable/+files/dus_$PV-1ubuntu1_all.deb -> $P.deb
	https://launchpad.net/~$PN/+archive/ubuntu/ppa/+files/guidus_$PV-1ubuntu1_all.deb -> $P-gui.deb
	https://launchpad.net/~$PN/+archive/ubuntu/ppa/+files/${PN}_$PV-1ubuntu1_all.deb -> $P-all.deb
	https://launchpad.net/~$PN/+archive/ubuntu/ppa/+files/$PN-plug_$PV-1ubuntu1_all.deb -> $P-plug.deb
	https://launchpad.net/~$PN/+archive/ubuntu/ppa/+files/$PN-nox_$PV-1ubuntu1_all.deb -> $P-nox.deb
	https://launchpad.net/~$PN/+archive/ubuntu/ppa/+files/usb-pack-efi_$PV-1ubuntu1_all.deb -> $P-efi.deb
"

S="${WORKDIR}"

SLOT="0"

LICENSE="GPL-3"
KEYWORDS="~amd64"

RESTRICT="strip"
QA_PREBUILT="*"
# REQUIRES_EXCLUDE="libcef.so" # Already inside

RDEPEND="
	app-admin/sudo
	gnome-extra/zenity
	sys-apps/gptfdisk
	sys-apps/pv
	sys-fs/ntfs3g
"
# About sys-fs/ntfs3g see my issue to make this dep optionsl https://bugs.launchpad.net/mkusb/+bug/2058962

src_unpack() {
	unpack_deb "$DISTDIR/$P-common.deb"
	unpack_deb "$DISTDIR/$P.deb"
	unpack_deb "$DISTDIR/$P-gui.deb"
	unpack_deb "$DISTDIR/$P-all.deb"
	unpack_deb "$DISTDIR/$P-plug.deb"
}

src_install() {
	cp -R "${S}"/* "${D}" || die "Installing binary files failed"

	# Extract documentation files
	# To solve
	# "Please fix the ebuild not to install compressed files (manpages, documentation) when automatic compression is used
	cd "$ED"
	find usr/share/ -name *.gz -exec gzip -d {} \;

	# Against
	# "QA Notice: The ebuild is installing to one or more unexpected paths:"
	from="usr/share/doc"
	to="usr/share/doc/$PF/"
	mkdir -p $to
	mv "$from/dus/" $to || die
	mv "$from/guidus/" $to || die
	mv "$from/mkusb/" $to || die
	mv "$from/mkusb-common/" $to || die
	mv "$from/mkusb-plug/" $to || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

# QA Notice about non-escaped $ - I created issue https://bugs.launchpad.net/mkusb/+bug/2059036
