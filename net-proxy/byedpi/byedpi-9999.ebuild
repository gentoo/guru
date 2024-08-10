# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3 systemd toolchain-funcs

DESCRIPTION="Bypass DPI SOCKS proxy"
HOMEPAGE="https://github.com/hufrea/byedpi/"
EGIT_REPO_URI="https://github.com/hufrea/byedpi.git"

LICENSE="MIT"
SLOT="0"

src_compile() {
	tc-export CC
	export CFLAGS LDFLAGS
	sed -i 's/ -O.\b/ /' Makefile

	default
}

src_install() {
	dobin ciadpi
	systemd_dounit "${FILESDIR}/${PN}.service"
}

