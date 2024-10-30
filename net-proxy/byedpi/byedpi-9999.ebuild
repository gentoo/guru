# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd toolchain-funcs

DESCRIPTION="Bypass DPI SOCKS proxy"
HOMEPAGE="https://github.com/hufrea/byedpi/"

inherit git-r3
EGIT_REPO_URI="https://github.com/hufrea/byedpi.git"

LICENSE="MIT"
SLOT="0"

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
	systemd_dounit "dist/linux/${PN}.service"

	insinto /etc
	newins "dist/linux/${PN}.conf" "${PN}.conf"
}
