# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

MY_PN=${PN#ooni-}
DESCRIPTION="OONI Probe network measurement tool for detecting internet censorship"
HOMEPAGE="https://ooni.org https://github.com/ooni/probe-cli"
SRC_URI="https://github.com/ooni/${MY_PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="0BSD Apache-2.0 BSD BSD-2 CC0-1.0 GPL-3 GPL-3+ ISC LGPL-3 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
PROPERTIES="test_network"
RESTRICT="test"

DOCS=( docs CODEOWNERS {CONTRIBUTING,Readme}.md )

src_compile() {
	ego build -v -ldflags="-s -w" ./cmd/ooniprobe
}

src_test() {
	ego test -short -race -tags shaping ./...
}

src_install() {
	dobin ooniprobe
	einstalldocs
}
