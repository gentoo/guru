# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A little tool to send messages to an XMPP contact or MUC"
HOMEPAGE="https://salsa.debian.org/mdosch/go-sendxmpp"
SRC_URI="
	https://salsa.debian.org/mdosch/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2
	https://tastytea.de/files/${P}-vendor.tar.xz
"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="BSD-2 BSD MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	ego build
}

src_install() {
	dobin go-sendxmpp
	default
}
