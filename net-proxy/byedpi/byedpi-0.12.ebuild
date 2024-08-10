# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit systemd toolchain-funcs

DESCRIPTION="Bypass DPI SOCKS proxy"
HOMEPAGE="https://github.com/hufrea/byedpi/"
SRC_URI="https://github.com/hufrea/byedpi/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	tc-export CC
	sed -i 's/ -O.\b/ /' Makefile
	# workaround for compiling without -O2
	sed -i 's/inline bool check_port/static inline bool check_port/' extend.c

	default
}

src_install() {
	dobin ciadpi
	systemd_dounit "${FILESDIR}/${PN}.service"
}

