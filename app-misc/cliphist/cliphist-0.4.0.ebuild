# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Wayland clipboard manager with support for multimedia"
HOMEPAGE="https://github.com/sentriz/cliphist"
SRC_URI="https://github.com/henri-gasc/cliphist/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3 MIT BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-apps/wl-clipboard
	x11-misc/xdg-utils
"
DEPEND="${RDEPEND}"

src_compile() {
	ego build
}

src_install() {
	dobin "${PN}"
	default
}
