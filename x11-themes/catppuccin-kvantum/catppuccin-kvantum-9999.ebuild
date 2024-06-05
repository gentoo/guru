# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Soothing pastel theme for Kvantum"
HOMEPAGE="https://github.com/catppuccin"

EGIT_REPO_URI="https://github.com/catppuccin/Kvantum.git"
inherit git-r3

S="${WORKDIR}/${P}/src"

RDEPEND="
	x11-themes/kvantum
"

LICENSE="MIT"
SLOT="0"

src_install() {
	insinto "/usr/share/Kvantum"
	doins -r Catppuccin-*
}
