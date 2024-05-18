# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="CLI tool for sourcehut"

HOMEPAGE="https://sr.ht/~emersion/hut/"

SRC_URI="
	https://git.sr.ht/~emersion/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/apraga/hut-vendor/releases/download/v${PV}/hut-${PV}-vendor.tar.xz
"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="AGPL-3"
SLOT="0"

KEYWORDS="~amd64"


DEPEND="${RDEPEND}"
BDEPEND="app-text/scdoc"

src_compile() {
	ego build
	emake doc/hut.1 completions
}

src_install() {
	dobin hut
	emake install PREFIX="${EPREFIX}/usr" DESTDIR="${D}"
}
