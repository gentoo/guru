# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit prefix

DESCRIPTION="ZFS bootloader for root-on-ZFS systems"
HOMEPAGE="https://zfsbootmenu.org"
SRC_URI="https://github.com/zbm-dev/zfsbootmenu/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}"/${PN}-stub-location.patch
)

RDEPEND="
app-shells/fzf
dev-lang/perl
dev-perl/boolean
dev-perl/Config-IniFiles
dev-perl/Sort-Versions
dev-perl/YAML-PP
sys-apps/kexec-tools
sys-block/mbuffer
sys-fs/zfs
sys-kernel/dracut
"

src_prepare() {
	default
	hprefixify bin/*
	if [[ -n ${BROOT} ]]; then
		sed -e "s,#!/bin/sh,#!${BROOT}/bin/sh," \
			-i install-tree.sh releng/version.sh || die
	fi
}

src_compile() {
	# There's a makefile in the source repo but it's only for install. There's
	# nothing to compile since zfsbootmenu is all scripts.
	true
}

src_install() {
	emake DESTDIR="${ED}" EXAMPLES="/usr/share/doc/${PF}" install
}

pkg_postinst () {
	elog "Please consult Gentoo wiki to configure the bootloader
	https://wiki.gentoo.org/wiki/ZFS/rootfs#ZFSBootMenu"
}
