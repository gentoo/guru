# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Configurable embedded Linux firmware update creator and runner"
HOMEPAGE="https://github.com/fwup-home/fwup"
SRC_URI="https://github.com/fwup-home/fwup/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

# Running tests requires dev-util/xdelta to be compiled with lzma support.
# Only run tests when the appropriate USE flag has been set.
RESTRICT="!test? ( test )"

BDEPEND="
	virtual/pkgconfig
	test? ( dev-util/xdelta:3[lzma] )
"

DEPEND="
	>=app-arch/libarchive-3.7.9:=[lzma]
	>=dev-libs/confuse-2.8:=
"

RDEPEND="
	${DEPEND}
	app-arch/zip
	dev-util/xdelta:3
	sys-fs/dosfstools
	sys-fs/mtools
	sys-fs/squashfs-tools
"

src_prepare() {
	default
	eautoreconf
}

src_test() {
	# The fwup tests do not like the portage sandbox. Make them play nice.

	# Certain tests make use of LD_PRELOAD, which does not work in the portage
	# sandbox. Most of these use the $WRITE_SHIM or $MOUNT_SHIM defined in
	# commmon.sh. Some tests define their own. Disable all of these so the
	# tests in question get skipped.
	sed -i 's/^\(WRITE\|MOUNT\|PREAD\|UBI\)_SHIM=".*"/\1_SHIM=""/' \
		'tests/common.sh' \
		'tests/222_block_cache_pread_count.test' \
		'tests/226_ubi_volume_write_success.test' \
		|| die 'Could not disable test shims'

	# set VERIFY_SYSCALLS_DISABLE, to disable tracing
	VERIFY_SYSCALLS_DISABLE="" emake check
}
