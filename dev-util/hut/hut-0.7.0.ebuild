# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="CLI tool for sourcehut"

HOMEPAGE="https://sr.ht/~xenrox/hut/"

SRC_URI="https://git.sr.ht/~xenrox/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://git.sr.ht/~xenrox/${PN}/refs/download/v${PV}/${PN}-v${PV}-vendor.tar.xz -> ${P}-vendor.tar.xz"

S="${WORKDIR}/hut-v${PV}"

LICENSE="AGPL-3"
SLOT="0"

KEYWORDS="~amd64"

BDEPEND="app-text/scdoc"

src_unpack() {
	default
	mv hut/vendor "${S}" || die
}

src_compile() {
	ego build
	emake doc/hut.1 completions
}

src_install() {
	dobin hut
	emake install PREFIX="${EPREFIX}/usr" DESTDIR="${D}"
}
