# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 pypi

DESCRIPTION="Funtoo's franken-chroot tool - chroot from AMD64 to ARM system"
HOMEPAGE="https://code.funtoo.org/bitbucket/users/drobbins/repos/fchroot/browse"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror test"

RDEPEND="
	${PYTHON_DEPS}
	app-emulation/qemu[qemu_user_targets_aarch64,qemu_user_targets_arm,static-user]
	dev-libs/glib[static-libs]
	dev-libs/libpcre[static-libs]
	sys-apps/attr[static-libs]
	sys-libs/zlib[static-libs]
"
