# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A customisable, universally compatible terminal status bar"
HOMEPAGE="https://github.com/liamg/shox"
SHA="6a0506aebcafcd598fbcd824be9c5f0608836ab1"
SRC_URI="
	https://github.com/liamg/shox/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/emanuelquintana-glitch/guru/releases/download/shox-deps-2024.01.25/${P}-deps.tar.xz
"

S="${WORKDIR}/${PN}-${SHA}"

LICENSE="Apache-2.0 BSD-2 BSD MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default
	cp "${WORKDIR}/go.mod" . || die
	cp "${WORKDIR}/go.sum" . || die
	cp -r "${WORKDIR}/vendor" . || die
}

src_compile() {
	ego build -mod=vendor ./cmd/shox
}

src_test() {
	ego test -mod=vendor ./...
}

src_install() {
	dobin shox
}
