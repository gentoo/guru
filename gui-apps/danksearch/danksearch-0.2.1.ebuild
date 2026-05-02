# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Indexed filesystem search in GO"
HOMEPAGE="https://github.com/AvengeMedia/danksearch"
SRC_URI="https://github.com/AvengeMedia/${PN}/releases/download/v${PV}/dsearch-${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/dsearch-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.24"

RESTRICT="strip"

src_compile() {
	sed -i '/^GOFLAGS=/d' "${S}/Makefile"
	sed -i "s/^VERSION=.*$/VERSION=\"${PV}\"/" "${S}/Makefile"
	sed -i 's/local\///' "${S}/assets/dsearch.service"

	default
}

src_install() {
	dobin "${S}/bin/dsearch"
	systemd_douserunit "${S}/assets/dsearch.service"
}
