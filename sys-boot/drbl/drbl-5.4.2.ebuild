# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Diskless Remote Boot in Linux"
HOMEPAGE="https://drbl.org"
SRC_URI="https://github.com/stevenshiau/drbl/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	net-misc/ipcalc
	sys-devel/bc
	sys-fs/e2fsprogs
	net-misc/wakeonlan
"
