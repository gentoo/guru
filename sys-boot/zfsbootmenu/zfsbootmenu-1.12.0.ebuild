# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ZFS bootloader for root-on-ZFS systems"
HOMEPAGE="https://zfsbootmenu.org"
SRC_URI="https://github.com/zbm-dev/zfsbootmenu/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}"/${PN}-branding.patch
)

RDEPEND="
app-shells/fzf
sys-apps/kexec-tools
sys-block/mbuffer
dev-perl/Sort-Versions
dev-perl/Config-IniFiles
dev-perl/YAML-PP
dev-perl/boolean
sys-fs/zfs
sys-kernel/dracut"

pkg_postinst () {
	elog "Please consult upstream doumentation to install the bootloader
	https://github.com/zbm-dev/zfsbootmenu"
}
