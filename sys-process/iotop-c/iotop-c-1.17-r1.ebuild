# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit fcaps

DESCRIPTION="top utility for IO (C port)"
HOMEPAGE="https://github.com/Tomas-M/iotop"
SRC_URI="https://github.com/Tomas-M/iotop/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sys-libs/ncurses:=
	!sys-process/iotop"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/iotop-${PV}"

FILECAPS=(
	cap_net_admin=eip usr/bin/iotop
)

src_compile() {
	emake V=1
}

src_install() {
	dobin iotop
	dodoc README.md
	doman iotop.8
}
