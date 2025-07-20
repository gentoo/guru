# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="An personal task manager that represents tasks as multitree nodes"
HOMEPAGE="https://github.com/climech/grit"
SRC_URI="https://github.com/climech/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"

LICENSE="MIT ISC BSD BSD-2 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lang/go-1.14
"

src_install() {
	emake DESTDIR="${D}" PREFIX='/usr' install
}
