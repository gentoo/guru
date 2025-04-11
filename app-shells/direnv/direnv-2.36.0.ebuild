# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Environment variable manager for shell"
HOMEPAGE="https://github.com/direnv/direnv"
SRC_URI="https://github.com/direnv/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	 https://files.demize.dev/gentoo/${CATEGORY}/${PN}/${P}-deps.tar.xz"

LICENSE="MIT"
# dependency licenses
LICENSE+=" BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# test dependencies are unreasonable, and tests fail without patches
RESTRICT="test"

# Upstream requires Go >=1.24
BDEPEND+=">=dev-lang/go-1.24:="

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	emake DESTDIR="${D}" PREFIX="/usr" install
}
