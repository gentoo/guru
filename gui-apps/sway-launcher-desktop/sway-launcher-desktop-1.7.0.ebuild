# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="TUI Application launcher with Desktop Entry support"
HOMEPAGE="https://github.com/Biont/sway-launcher-desktop"
SRC_URI="https://github.com/Biont/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-shells/fzf"

src_install() {
	newbin ${PN}.sh ${PN}
}
