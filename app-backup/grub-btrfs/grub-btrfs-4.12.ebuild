# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="Improves Grub by adding btrfs snapshots to the Grub menu."
HOMEPAGE="https://github.com/Antynea/grub-btrfs"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Antynea/grub-btrfs"
else
	SRC_URI="https://github.com/Antynea/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="systemd"
PATCHES=( "${FILESDIR}/${PN}-9999-remove-docs-from-make.patch" )

DEPEND="
	sys-fs/btrfs-progs
	sys-boot/grub
	app-alternatives/awk
	>=app-shells/bash-4
	sys-fs/inotify-tools
"
RDEPEND="${DEPEND}"

src_compile(){
	true
}

src_install(){
	local conf
	if use systemd; then
		conf+="SYSTEMD=true OPENRC=false"
	else
		conf+="OPENRC=true SYSTEMD=false"
	fi
	emake DESTDIR="${D}" ${conf} install || die
	dodoc README.md
	mv ./initramfs/readme.md initramfs-overlayfs.md || die
	dodoc initramfs-overlayfs.md
	doman temp/grub-btrfs.8
	doman temp/grub-btrfsd.8
}

pkg_postinst() {
	elog "run 'grub-mkconfig -o /boot/grub/grub.cfg' to update your Grub menu."
	elog "update the /etc/grub.d/41_snapshots-btrfs script if neccesary."
	elog "(e.g. with dispatch-conf or etc-update)"
	optfeature "LVM/ LUKS support" sys-boot/grub[device-mapper]
}
