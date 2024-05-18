# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Improved and modern fdupes alternative"
HOMEPAGE="https://github.com/OSPG/godedupe"
SRC_URI="https://github.com/OSPG/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build
}

src_install() {
	dobin godedupe
}
