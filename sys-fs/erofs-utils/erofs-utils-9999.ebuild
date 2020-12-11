# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Userspace tools for EROFS images"
HOMEPAGE="https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git"
EGIT_BRANCH="experimental"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="fuse lz4 selinux +uuid"

RDEPEND="
	fuse? ( sys-fs/fuse:0 )
	lz4? ( >=app-arch/lz4-1.9 )
	selinux? ( sys-libs/libselinux )
	uuid? ( sys-apps/util-linux )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable fuse) \
		$(use_enable lz4) \
		$(use_with selinux) \
		$(use_with uuid)
}
