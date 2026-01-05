# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Securely store and access AWS credentials in development environments"
HOMEPAGE="https://github.com/ByteNess/aws-vault"
SRC_URI="
	https://github.com/ByteNess/aws-vault/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ixti/aws-vault/releases/download/v${PV}/${P}-vendor.tar.xz
"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -ldflags "-s -w -X \"main.Version=${PV}\"" -o "${PN}"
}

src_install() {
	dobin "${PN}"
	dodoc README.md USAGE.md
}
