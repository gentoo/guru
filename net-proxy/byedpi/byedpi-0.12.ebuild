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
	export CFLAGS LDFLAGS
	sed -i 's/ -O.\b/ /' Makefile || die
	# respect LDFLAGS
	sed -i 's/$(CFLAGS) /$(CFLAGS) $(LDFLAGS) /' Makefile || die
	# workaround for compiling without -O2
	# https://github.com/hufrea/byedpi/commit/3fee8d5aed122f34ec13637f5f4b1502d13cc923
	sed -i 's/inline bool check_port/static inline bool check_port/' extend.c || die

	default
}

src_install() {
	dobin ciadpi
	systemd_dounit "${FILESDIR}/${PN}.service"
}

