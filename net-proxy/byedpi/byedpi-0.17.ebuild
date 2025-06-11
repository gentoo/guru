# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd toolchain-funcs

DESCRIPTION="Bypass DPI SOCKS proxy"
HOMEPAGE="https://github.com/hufrea/byedpi"
SRC_URI="https://github.com/hufrea/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="acct-user/byedpi"

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

	newinitd "${FILESDIR}"/byedpi.initd-r2 byedpi
	newconfd "${FILESDIR}"/byedpi.confd byedpi
	systemd_dounit "dist/linux/${PN}.service"

	insinto /etc
	newins "dist/linux/${PN}.conf" "${PN}.conf"
}
