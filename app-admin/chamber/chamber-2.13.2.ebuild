# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Managing secrets in AWS SSM Parameter Store"
HOMEPAGE="https://github.com/segmentio/chamber"
SRC_URI="
	https://github.com/segmentio/chamber/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ixti/chamber/releases/download/v${PV}/${P}-vendor.tar.xz
"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	>=dev-lang/go-1.19
"

src_compile() {
	ego build
}

src_install() {
	dobin "${PN}"
	dodoc README.md CHANGELOG.md
}
