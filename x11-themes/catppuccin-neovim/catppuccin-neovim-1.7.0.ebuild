# Copyright 2024 Catppuccin
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="Soothing pastel theme for Neovim"
HOMEPAGE="https://github.com/catppuccin/nvim"
SRC_URI="https://github.com/catppuccin/nvim/archive/refs/tags/v"${PV}".tar.gz -> catppuccin-neovim-"${PV}".tar.gz"
S=""${WORKDIR}"/nvim-"${PV}""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
DEPEND="app-editors/neovim"

src_unpack() {
	tar -xpf /var/tmp/portage/x11-themes/catppuccin-neovim-"${PV}"/distdir/catppuccin-neovim-"${PV}".tar.gz
}

src_install() {
	cd ./colors
	mkdir --parents "${D}"/usr/share/nvim/runtime/colors
	cp -r *.vim "${D}"/usr/share/nvim/runtime/colors
}
