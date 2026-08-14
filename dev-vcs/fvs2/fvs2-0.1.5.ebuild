# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

# See https://github.com/mirkobrombin/FVS for the first version
DESCRIPTION="Standalone CLI for FVS v2"
HOMEPAGE="https://github.com/fvs-lab/fvs2"
SRC_URI="
	https://github.com/fvs-lab/fvs2/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build ./cmd/fvs2
}

src_install() {
	dobin ${PN}
	dodoc README.md
}
