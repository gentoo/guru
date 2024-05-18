# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

DESCRIPTION="vim plugin: a universal set of defaults that (hopefully) everyone can agree on"
HOMEPAGE="
	https://github.com/tpope/vim-sensible
	http://www.vim.org/scripts/script.php?script_id=4391
"
SRC_URI="https://github.com/tpope/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="vim"
KEYWORDS="~amd64 ~x86"
