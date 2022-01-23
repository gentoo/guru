# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Funtoo's franken-chroot tool - chroot from AMD64 to ARM system"
HOMEPAGE="https://code.funtoo.org/bitbucket/users/drobbins/repos/fchroot/browse"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

RESTRICT="mirror test"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	app-emulation/qemu[qemu_softmmu_targets_x86_64,qemu_softmmu_targets_aarch64,qemu_softmmu_targets_arm,static-user]
	dev-libs/glib[static-libs]
	dev-libs/libpcre[static-libs]
	sys-apps/attr[static-libs]
	sys-libs/zlib[static-libs]
"
