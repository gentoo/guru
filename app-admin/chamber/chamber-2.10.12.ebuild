# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Managing secrets in AWS SSM Parameter Store"
HOMEPAGE="https://github.com/segmentio/chamber"
SRC_URI="
	https://github.com/segmentio/chamber/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ixti/chamber/releases/download/v${PV}/${P}-deps.tar.gz
"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	go build -ldflags "-s -w -X \"main.Version=${PV}\"" -o "${PN}" || die "go build failed"
}

src_install() {
	dobin "${PN}"
	dodoc README.md CHANGELOG.md
}
