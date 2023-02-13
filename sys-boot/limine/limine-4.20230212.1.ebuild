# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Limine is a modern, advanced x86/x86_64 BIOS/UEFI multiprotocol bootloader"
HOMEPAGE="https://limine-bootloader.org/"
SRC_URI="https://github.com/limine-bootloader/limine/releases/download/v${PV}/limine-${PV}.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+bios +bios-pxe +bios-cd +limine-deploy +uefi +cd-efi +uefi32 +uefi64 +uefiaa64"
REQUIRED_USE="
	uefi32? ( uefi )
	uefi64? ( uefi )
	uefiaa64? ( uefi )
	cd-efi? ( uefi )
	uefi? ( || ( uefi32 uefi64 uefiaa64 cd-efi ) )

	bios-pxe? ( bios )
	bios-cd? ( bios )
	limine-deploy? ( bios )
	bios? ( || ( bios-pxe bios-cd limine-deploy ) )
"

MY_LLVM_TARGETS="AArch64 ARM X86"
MY_LLVM_FLAGS="llvm_targets_${MY_LLVM_TARGETS// /(-),llvm_targets_}(-)"

BDEPEND="
	app-arch/gzip
	dev-lang/nasm
	sys-apps/findutils
	sys-devel/clang[${MY_LLVM_FLAGS}]
	sys-devel/lld
	sys-devel/llvm[${MY_LLVM_FLAGS}]

	cd-efi? ( sys-fs/mtools )
"

src_configure() {
	local myconf=(
		"$(use_enable bios)"
		"$(use_enable bios-cd)"
		"$(use_enable bios-pxe)"
		"$(use_enable limine-deploy)"

		"$(use_enable uefi)"
		"$(use_enable uefi32 uefi-ia32)"
		"$(use_enable uefi64 uefi-x86-64)"
		"$(use_enable uefiaa64 uefi-aarch64)"
		"$(use_enable cd-efi)"
	)

	CROSS_TOOLCHAIN=llvm \
	econf "${myconf[@]}"
}
