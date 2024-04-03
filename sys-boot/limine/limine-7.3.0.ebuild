# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Limine is a modern, advanced, and portable BIOS/UEFI multiprotocol bootloader"
HOMEPAGE="https://limine-bootloader.org/"
SRC_URI="https://github.com/limine-bootloader/limine/releases/download/v${PV}/limine-${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+bios +bios-pxe +bios-cd +cd-efi +uefi32 +uefi64 +uefiaa64 +uefirv64"

MY_LLVM_TARGETS="AArch64 ARM X86 RISCV"
MY_LLVM_FLAGS="llvm_targets_${MY_LLVM_TARGETS// /(-),llvm_targets_}(-)"

BDEPEND="
	app-alternatives/gzip
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

		"$(use_enable uefi32 uefi-ia32)"
		"$(use_enable uefi64 uefi-x86-64)"
		"$(use_enable uefiaa64 uefi-aarch64)"
		"$(use_enable uefirv64 uefi-riscv64)"
		"$(use_enable cd-efi uefi-cd)"
	)

	TOOLCHAIN_FOR_TARGET=llvm \
	econf "${myconf[@]}"
}
