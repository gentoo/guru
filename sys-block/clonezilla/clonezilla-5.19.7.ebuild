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
	sys-apps/file
	sys-block/parted
	sys-boot/drbl
	sys-apps/gptfdisk
	net-misc/wget
	sys-block/partclone
	sys-block/partimage
	sys-fs/ntfs3g[ntfsprogs]
	net-misc/udpcast
	sys-apps/smartmontools
	app-text/html2text
	app-arch/pigz
	app-arch/zstd
	sys-libs/ncurses
	apfs? ( sys-block/partclone[apfs] )
	btrfs? ( sys-block/partclone[btrfs] )
	e2fs? ( sys-block/partclone[e2fs] )
	exfat? ( sys-block/partclone[exfat] )
	f2fs? ( sys-block/partclone[f2fs] )
	fat? ( sys-block/partclone[fat] )
	fuse? ( sys-block/partclone[fuse] )
	hfs? ( sys-block/partclone[hfs] )
	minix? ( sys-block/partclone[minix] )
	nilfs2? ( sys-block/partclone[nilfs2] )
	ntfs? ( sys-block/partclone[ntfs] )
	xfs? ( sys-block/partclone[xfs] )
"
