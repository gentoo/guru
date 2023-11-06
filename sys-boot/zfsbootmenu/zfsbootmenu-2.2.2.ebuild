# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

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

src_compile() {
	# There's a makefile in the source repo but it's only for install. There's
	# nothing to compile since zfsbootmenu is all scripts.
	true
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst () {
	elog "Please consult upstream doumentation to install the bootloader
	https://github.com/zbm-dev/zfsbootmenu"
}
