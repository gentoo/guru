# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_COMMIT="cadd9675822cc02eace137eb918a4362c69bec9e"

DESCRIPTION="top utility for IO (C port)"
HOMEPAGE="https://github.com/Tomas-M/iotop"
SRC_URI="https://github.com/Tomas-M/iotop/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sys-libs/ncurses:=
	!sys-process/iotop"
DEPEND="${RDEPEND}"

S="${WORKDIR}/iotop-${MY_COMMIT}"

src_install() {
	dobin iotop
	dodoc README.md
}
