# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Mass repository cloning tool for GitHub/GitLab/Bitbucket"
HOMEPAGE="https://github.com/gabrie30/ghorg"
SRC_URI="https://github.com/gabrie30/ghorg/archive/v${PV}.tar.gz -> ${P}.tar.gz
	http://joecool.ftfuchs.com/godeps/${P}-vendor.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	dev-lang/go:=
"
RDEPEND="${DEPEND}"

src_compile() {
	ego build
}

src_install() {
	dobin ${PN}

	default
}
