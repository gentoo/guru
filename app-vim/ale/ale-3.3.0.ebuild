# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

DESCRIPTION="Check syntax in Vim asynchronously and fix files, with LSP support"
HOMEPAGE="https://github.com/dense-analysis/ale"
SRC_URI="https://github.com/dense-analysis/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="~amd64"

VIM_PLUGIN_HELPFILES="ale"

src_install(){
	vim-plugin_src_install ale_linters rplugin
}
