# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="CLI tool for sourcehut"

HOMEPAGE="https://sr.ht/~xenrox/hut/"

SRC_URI="
	https://git.sr.ht/~xenrox/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/cjbayliss/hut-vendor/releases/download/v${PV}/hut-${PV}-vendor.tar.xz
"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="AGPL-3"
SLOT="0"

KEYWORDS="~amd64"

BDEPEND="app-text/scdoc"

src_compile() {
	ego build
	emake doc/hut.1 completions
}

src_install() {
	dobin hut
	emake install PREFIX="${EPREFIX}/usr" DESTDIR="${D}"
}
