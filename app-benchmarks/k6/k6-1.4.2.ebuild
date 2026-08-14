# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Load testing tool"
HOMEPAGE="https://github.com/grafana/k6"
SRC_URI="https://github.com/grafana/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://distfiles.dutra.sh/distfiles/${P}-vendor.tar.xz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Tests requires network connection
RESTRICT=test

src_compile() {
	ego build -v -x -o ${PN}
}

src_install() {
	dobin ${PN}
}
