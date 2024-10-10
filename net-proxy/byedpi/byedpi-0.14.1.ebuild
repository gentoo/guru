# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd toolchain-funcs

DESCRIPTION="Bypass DPI SOCKS proxy"
HOMEPAGE="https://github.com/hufrea/byedpi/"
SRC_URI="https://github.com/hufrea/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default

	# respect optimization level
	sed -i 's/ -O.\b/ /' Makefile || die
}

src_configure() {
	tc-export CC
}

src_install() {
	dobin ciadpi
	einstalldocs

	newinitd "${FILESDIR}"/byedpi.initd byedpi
	newconfd "${FILESDIR}"/byedpi.confd byedpi
	systemd_dounit "${FILESDIR}/${PN}.service"
}
