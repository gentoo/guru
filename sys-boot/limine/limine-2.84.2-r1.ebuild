# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_LIBTOOL=none
inherit autotools toolchain-funcs

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

PATCHES=(
	"${FILESDIR}/${PN}-2.84.2-r1-limine-install-respect-ldflags.patch"
)

src_configure() {
	local myconf=(
		"$(use_enable eltorito-efi)"
	)

	LIMINE_LD="$(tc-getLD)" \
	LIMINE_AR="$(tc-getAR)" \
	LIMINE_AS="$(tc-getAS)" \
	LIMINE_OBJCOPY="$(tc-getOBJCOPY)" \
	LIMINE_OBJDUMP="$(tc-getOBJDUMP)" \
	LIMINE_READELF="$(tc-getREADELF)" \
	econf "${myconf[@]}"
}
