# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

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
	virtual/awk
	>=app-shells/bash-4
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile(){
	true
}
src_install(){
	default
	dodoc README.md
	mv ./initramfs/readme.md initramfs-overlayfs.md || die
	dodoc initramfs-overlayfs.md
}

pkg_postinst() {
	elog "run 'grub-mkconfig -o /boot/grub/grub.cfg' to update your Grub menu."
	elog "update your /etc/grub.d/41_snapshots-btrfs script (e.g. with dispatch-conf or etc-update)"
    optfeature "LVM/ LUKS support" sys-boot/grub[device-mapper]
}
