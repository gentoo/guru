# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="OONI Probe network measurement tool for detecting internet censorship"
HOMEPAGE="https://ooni.org https://github.com/ooni/probe-cli"
SRC_URI="https://github.com/ooni/probe-cli/releases/download/v${PV}/${P}.tar.gz"

LICENSE="0BSD Apache-2.0 BSD BSD-2 CC0-1.0 GPL-3 GPL-3+ ISC LGPL-3 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-db/sqlite:3[icu]"
RDEPEND="${DEPEND}"

DOCS=( docs CODEOWNERS {CODE_OF_CONDUCT,CONTRIBUTING,DESIGN,Readme}.md )

src_prepare() {
	default

	# remove ooni's build tool
	rm -r internal/cmd/buildtool || die
}

src_configure() {
	GOFLAGS+=" -tags=shaping"
}

src_compile() {
	ego build ./cmd/ooniprobe
	ego build ./internal/cmd/miniooni
	ego build ./internal/cmd/oohelperd
}

src_test() {
	local -x GOFLAGS
	GOFLAGS="${GOFLAGS//-v/}"
	GOFLAGS="${GOFLAGS//-x/}"

	ego test -short -race ./...
}

src_install() {
	dobin ooniprobe miniooni oohelperd
	einstalldocs
}
