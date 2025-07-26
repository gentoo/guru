# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Wireguard client that exposes itself as a proxy"
HOMEPAGE="https://github.com/whyvl/wireproxy"
SRC_URI="https://github.com/whyvl/wireproxy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.xz"
SRC_URI+=" https://github.com/iguanajuice/guru-distfiles/raw/refs/heads/main/net-proxy/wireproxy/${P}-vendor.tar.xz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build ./cmd/wireproxy
}

src_install() {
	dobin wireproxy
}
