# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

DESCRIPTION="Dark theme for Vim"
HOMEPAGE="https://draculatheme.com/vim"
SRC_URI="https://github.com/${PN}/vim/archive/refs/tags/v${PV}.tar.gz -> ${P}-vim.tar.gz"
S="${WORKDIR}/vim-${PV}"

LICENSE="MIT"
KEYWORDS="~amd64"

VIM_PLUGIN_HELPFILES="dracula"

src_prepare() {
	default
	rm -r .github || die

	# collision with app-vim/airline-themes
	rm -r autoload/airline || die

	# avoid collision with other packages
	cd after/syntax || die
	for file in *.vim; do
		mkdir "${file%.vim}" || die
		mv "${file}" "${file%.vim}/${PN}.vim" || die
	done
}
