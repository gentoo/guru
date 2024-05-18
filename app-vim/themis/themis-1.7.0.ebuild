# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo vim-plugin

DESCRIPTION="A testing framework for Vim script"
HOMEPAGE="https://github.com/thinca/vim-themis"
SRC_URI="https://github.com/thinca/vim-${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/vim-${P}"

LICENSE="ZLIB"
KEYWORDS="~amd64 ~x86"

VIM_PLUGIN_HELPFILES="themis"

src_test() {
	edo bash ./bin/themis
}

src_install() {
	vim-plugin_src_install bin

	dosym -r /usr/share/vim/vimfiles/bin/themis /usr/bin/themis
	fperms +x /usr/share/vim/vimfiles/bin/themis
}
