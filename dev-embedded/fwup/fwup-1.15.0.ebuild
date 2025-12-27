# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Configurable embedded Linux firmware update creator and runner"
HOMEPAGE="https://github.com/fwup-home/fwup"
SRC_URI="https://github.com/fwup-home/fwup/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=app-arch/libarchive-3.7.9
	app-arch/zip
	>=dev-libs/confuse-2.8
	dev-util/xdelta:3
	sys-fs/dosfstools
	sys-fs/mtools
	sys-fs/squashfs-tools
"

src_prepare() {
	default
	./autogen.sh
}

src_test() {
	# The fwup tests do not like the portage sandbox. Make them play nice.

	# Modify tests/common.sh to ensure $WRITE_SHIM and $MOUNT_SHIM point to
	# files that don't exist. This is needed to ensure tests don't try to use
	# LD_PRELOAD.
	sed -i 's/^\(WRITE\|MOUNT\)_SHIM=".*"/\1_SHIM=""/' 'tests/common.sh' \
		|| die 'Could not sed tests/common.sh'

	# set VERIFY_SYSCALLS_DISABLE, to disable tracing
	VERIFY_SYSCALLS_DISABLE="" emake check
}
