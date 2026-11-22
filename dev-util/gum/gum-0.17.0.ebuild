# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
 
EAPI=8

inherit go-module
 
DESCRIPTION="A tool for glamorous shell scripts"
HOMEPAGE="https://github.com/charmbracelet/gum"
SRC_URI="
https://github.com/charmbracelet/gum/archive/v${PV}.tar.gz -> ${P}.tar.gz
https://github.com/Syntrait/guru-distfiles/releases/download/${P}-vendor.tar.xz/${P}-vendor.tar.xz
"
 
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
 
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
  ego build
}

src_install() {
  dobin gum

  default
}
