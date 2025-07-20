# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="Remote repository management made easy"
HOMEPAGE="https://github.com/x-motemen/ghq"
SRC_URI="https://github.com/x-motemen/ghq/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -o "bin/${PN}"
}

src_install() {
	dobin "bin/${PN}"
	dodoc README.adoc
}
