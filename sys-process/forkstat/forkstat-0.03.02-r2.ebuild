# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Logs process fork(), exec() and exit() activity"
HOMEPAGE="https://github.com/ColinIanKing/forkstat"
SRC_URI="https://github.com/ColinIanKing/forkstat/archive/refs/tags/V${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
PATCHES=( "${FILESDIR}/musl-prio.patch" )
src_prepare() {
	default
	sed -i 's/8.gz/8/g' Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="$CFLAGS -DVERSION='\"${PV}\"'"
}
