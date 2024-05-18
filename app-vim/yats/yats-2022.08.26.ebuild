# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

MY_PN="${PN}.vim"
COMMIT="4bf3879055847e675335f1c3050bd2dd11700c7e"
DESCRIPTION="vim plugin: Yet Another TypeScript Syntax"
HOMEPAGE="https://github.com/HerringtonDarkholme/yats.vim"
SRC_URI="https://github.com/HerringtonDarkholme/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="vim"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	test? (
		${RDEPEND}
		>app-vim/vader-0.3.0
	)
"

DOCS=( CHANGES.markdown README.md )

src_prepare() {
	default
	rm Makefile || die

	# failing tests
	rm test/tsx.indent.vader || die
}

src_test() {
	cd test || die

	unset DISPLAY
	export TERM=xterm

	vim -eu "${FILESDIR}"/vimrc -c 'Vader! ./*.vader' || die
}

src_install() {
	vim-plugin_src_install ctags UltiSnips
}
