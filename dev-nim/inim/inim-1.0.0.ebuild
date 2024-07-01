# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Interactive Nim Shell / REPL / Playground"
HOMEPAGE="https://github.com/inim-repl/INim"
SRC_URI="https://github.com/${PN}-repl/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/INim-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-nim/cligen-1.5.22
	>=dev-nim/noise-0.1.4
"

DOCS=( {README,SECURITY}.md readme.gif )
