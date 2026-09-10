# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="API & CLI for System & Process Monitoring "
HOMEPAGE="https://github.com/AvengeMedia/dgop"
SRC_URI="https://github.com/AvengeMedia/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.25.0"

PATCHES=("${FILESDIR}"/"${PN}-0.2.3-no-strip.patch")

src_configure() {
	sed -i '/^GOFLAGS=/d' "${S}/Makefile"
	sed -i "s/^VERSION=.*$/VERSION=\"${PV}\"/" "${S}/Makefile"

	default
}

src_install() {
	dobin "${S}/bin/${PN}"
}
