# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Improves Grub by adding btrfs snapshots to the Grub menu."
HOMEPAGE="https://github.com/Antynea/grub-btrfs"
SRC_URI="https://github.com/Antynea/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
PATCHES=( "${FILESDIR}/${P}-remove-docs-from-make.patch" )

DEPEND="
	sys-fs/btrfs-progs
	sys-boot/grub
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
}
src_compile(){
	true
}
src_install(){
	default
	dodoc README.md
	mv ./initramfs/readme.md initramfs-overlayfs.md
	dodoc initramfs-overlayfs.md
}

pkg_postinst() {
	elog "run 'grub-mkconfig -o /boot/grub/grub.cfg' to update your Grub menu."
}
