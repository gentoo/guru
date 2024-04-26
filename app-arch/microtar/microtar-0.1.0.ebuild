# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A lightweight tar library written in ANSI C"
HOMEPAGE="https://github.com/rxi/microtar"
SRC_URI="https://github.com/rxi/microtar/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	tc-export CC
	${CC} ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} -I./src -fPIC -shared -Wl,-soname=libmicrotar.so src/microtar.c -o libmicrotar.so
}

src_install() {
	dolib.so libmicrotar.so
	doheader src/microtar.h
	dodoc README.md
}
