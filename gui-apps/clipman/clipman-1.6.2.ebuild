# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A basic clipboard manager for Wayland."
HOMEPAGE="https://github.com/chmouel/clipman/"
SRC_URI="https://github.com/chmouel/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# Using a dependency tarball as per https://devmanual.gentoo.org/eclass-reference/go-module.eclass/index.html
DEPS_URI="https://kdrive.infomaniak.com/2/app/192129/share/901d89f7-3efa-4922-a7ee-550314e02a8e/files/21/download -> ${P}-deps.tar.xz"
SRC_URI+=" ${DEPS_URI}"

LICENSE="BSD GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man"

DEPEND="
	>=gui-apps/wl-clipboard-2
	gui-libs/wlroots
"

src_compile() {
	ego build .
}

src_install() {
	dobin ${PN}
	use man && doman docs/${PN}.1
	default
}
