# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="API & CLI for System & Process Monitoring "
HOMEPAGE="https://github.com/duxlabs-dev/dux-gop"
SRC_URI="https://github.com/duxlabs-dev/${PN}/releases/download/v${PV}/dgop-${PV}.tar.gz"

S="${WORKDIR}/dgop-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.26.0"

PATCHES=("${FILESDIR}"/"${PN}-0.2.3-no-strip.patch")

src_configure() {
	sed -i "s/^VERSION=.*$/VERSION=\"${PV}\"/" "${S}/Makefile"

	default
}

src_install() {
	dobin "${S}/bin/dgop"
}
