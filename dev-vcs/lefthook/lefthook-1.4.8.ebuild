# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Fast and powerful Git hooks manager for any type of projects"
HOMEPAGE="https://github.com/evilmartians/lefthook"
SRC_URI="
	https://github.com/evilmartians/lefthook/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ixti/lefthook/releases/download/v${PV}/${P}-vendor.tar.xz
"

LICENSE="Apache-2.0 MIT BSD BSD-2 MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}
	dev-vcs/git
"

BDEPEND="
	>=dev-lang/go-1.20
"

src_compile() {
	ego build
}

src_install() {
	dobin "${PN}"
	dodoc README.md CHANGELOG.md docs/configuration.md docs/usage.md
}
