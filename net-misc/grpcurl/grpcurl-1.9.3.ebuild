# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Command-line tool for interacting with gRPC servers"
HOMEPAGE="https://github.com/fullstorydev/grpcurl"

SRC_URI="https://github.com/fullstorydev/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/kuprTheMan/contribute-deps/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64"

RESTRICT="test"

src_compile() {
	ego build -o ${PN} -v -ldflags "-X 'main.version=${PV}'" ./cmd/...
}

src_install() {
	dobin ${PN}

	dodoc README.md

	default
}
