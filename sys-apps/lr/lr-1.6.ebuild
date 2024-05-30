# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="list files, recursively"
HOMEPAGE="https://github.com/leahneukirchen/lr"
SRC_URI="https://github.com/leahneukirchen/lr/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=( "${FILESDIR}/options-order.patch" )

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="$CFLAGS"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
