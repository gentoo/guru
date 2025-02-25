# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Pretty fancy and modern terminal file manager"
HOMEPAGE="https://superfile.netlify.app/"
SRC_URI="https://github.com/yorukot/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/0.2/${P}-vendor.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
    ego build -o bin/spf
}

src_install() {
    dobin bin/spf
}
