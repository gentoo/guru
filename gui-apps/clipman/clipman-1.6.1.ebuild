# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A basic clipboard manager for Wayland."
HOMEPAGE="https://github.com/yory8/clipman"
SRC_URI="https://github.com/yory8/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# Using a dependency tarball as per https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html
DEPS_URI="https://kdrive.infomaniak.com/app/share/192129/afaeda87-1372-40fc-b165-d509de1e747a/19/download -> ${P}-deps.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="BSD GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man"

DEPEND="
  >=gui-apps/wl-clipboard-2
  gui-libs/wlroots
"
RDEPEND="${DEPEND}"
BDEPEND="
  dev-lang/go
"

src_compile() {
  ego build .
}

src_install() {
  dobin ${PN}
  use man && doman docs/${PN}.1
  default
}
