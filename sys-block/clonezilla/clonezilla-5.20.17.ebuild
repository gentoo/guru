# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Clonezilla is a partition and disk imaging/cloning program"
HOMEPAGE="https://clonezilla.org"
SRC_URI="https://github.com/stevenshiau/clonezilla/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="apfs btrfs +e2fs exfat f2fs fat fuse hfs minix nilfs2 ntfs xfs"

# reiserfs? ( sys-block/partclone[reiserfs] )
# ufs? ( sys-block/partclone[ufs] )
# vmfs? ( sys-block/partclone[vmfs] )
#
# As of partclone v0.3.50 the above IUSE flags
# have been disabled.
# See: 1ec2e49cae9276b187098905d7a7ed45744dd1f6

RDEPEND="
	app-arch/pigz
	app-arch/zstd
	app-text/html2text
	net-misc/udpcast
	net-misc/wget
	sys-apps/file
	sys-apps/gptfdisk
	sys-apps/smartmontools
	sys-block/partclone[apfs?,btrfs?,e2fs?,exfat?,f2fs?,fat?,fuse?,hfs?,minix?,nilfs2?,ntfs?,xfs?]
	sys-block/parted
	sys-block/partimage
	sys-boot/drbl
	sys-fs/ntfs3g[ntfsprogs]
	sys-libs/ncurses
"
