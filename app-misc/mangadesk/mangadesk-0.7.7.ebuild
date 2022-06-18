# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Terminal Client for MangaDex"
HOMEPAGE="https://github.com/darylhjd/mangadesk"
SRC_URI="https://github.com/darylhjd/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build
}

src_install() {
	dobin ${PN}
	einstalldocs
}
