# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

if [[ -z ${PV%%*9999} ]]; then
	EGIT_REPO_URI="https://github.com/Thomas-Tsai/${PN}.git"
	inherit git-r3
else
	[[ -n ${PV%%*_p*} ]] && MY_PV="${PV}"
	SRC_URI="
		https://github.com/Thomas-Tsai/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Partition cloning tool"
HOMEPAGE="https://partclone.org"

LICENSE="GPL-2"
SLOT="0"
IUSE="
apfs btrfs +e2fs exfat f2fs fat fuse hfs minix ncurses nilfs2 ntfs
reiserfs static test ufs vmfs xfs
"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/openssl:0=
	e2fs? ( sys-fs/e2fsprogs )
	btrfs? ( sys-apps/util-linux )
	fuse? ( sys-fs/fuse:3 )
	ncurses? ( sys-libs/ncurses:0= )
	nilfs2? ( sys-fs/nilfs-utils )
	ntfs? ( sys-fs/ntfs3g )
	reiserfs? ( sys-fs/progsreiserfs )
	xfs? ( sys-apps/util-linux )
	static? (
		dev-libs/openssl:0[static-libs]
		e2fs? ( sys-fs/e2fsprogs[static-libs] )
		btrfs? ( sys-apps/util-linux[static-libs] )
		fuse? ( sys-fs/fuse:0[static-libs] )
		ncurses? ( sys-libs/ncurses:0[static-libs] )
		nilfs2? ( sys-fs/nilfs-utils[static-libs] )
		ntfs? ( sys-fs/ntfs3g[static-libs] )
		reiserfs? ( sys-fs/progsreiserfs[static-libs] )
	)
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${PN}-ntfs-headers.patch
	"${FILESDIR}"/${PN}-reiser4-test.patch
)

DOCS=(
	AUTHORS
	ChangeLog
	HACKING
	NEWS
	README.md
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable e2fs extfs)
		$(use_enable apfs)
		$(use_enable btrfs)
		$(use_enable exfat)
		$(use_enable f2fs)
		$(use_enable fat)
		$(use_enable fuse)
		$(use_enable hfs hfsp)
		$(use_enable minix)
		$(use_enable ncurses ncursesw)
		$(use_enable nilfs2)
		$(use_enable ntfs)
		$(use_enable reiserfs)
		$(use_enable test fs-test)
		$(use_enable static)
		$(use_enable vmfs)
		$(use_enable ufs)
		$(use_enable xfs)
		--disable-jfs
		--disable-reiser4
	)
	econf "${myconf[@]}"
}
