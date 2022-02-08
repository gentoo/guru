# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_LIBTOOL=none
inherit autotools

DESCRIPTION="Limine is a modern, advanced x86/x86_64 BIOS/UEFI multiprotocol bootloader."
HOMEPAGE="https://limine-bootloader.org/"
SRC_URI="https://github.com/limine-bootloader/limine/releases/download/v${PV}/limine-${PV}.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+eltorito-efi"

BDEPEND="
	sys-apps/findutils
	dev-lang/nasm
	app-arch/gzip
	eltorito-efi? ( sys-fs/mtools )
"
PATCHES="
	${FILESDIR}/${PN}-2.83-build-Make-eltorito-efi-build-manually-toggleable.patch
"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable eltorito-efi)
	)

	econf "${myconf[@]}"
}
