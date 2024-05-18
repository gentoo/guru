# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo vim-plugin

COMMIT="e1fe727127a813095854a5b063c15e955a77eafb"
DESCRIPTION="vim plugin: display git status flags in NERDTree"
HOMEPAGE="https://github.com/Xuyuanp/nerdtree-git-plugin"
SRC_URI="https://github.com/Xuyuanp/${PN}-plugin/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-plugin-${COMMIT}"

LICENSE="WTFPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	app-vim/nerdtree
	dev-vcs/git
"
BDEPEND="test? (
	${RDEPEND}
	app-vim/themis
)"

src_test() {
	edo themis ./tests --runtimepath "${EPREFIX}"/usr/share/vim/vimfiles
}

src_install() {
	vim-plugin_src_install nerdtree_plugin
}
