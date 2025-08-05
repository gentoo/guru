# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

MY_PN="${PN}.vim"
COMMIT="c3d71452154a12ccf9f6e4219ccbd625474602e5"
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

src_compile() {
	:
}

src_test() {
	unset DISPLAY
	local -x TERM="xterm"

	cd test || die
	vim -eu "${FILESDIR}"/vimrc -c "Vader! -q indent.vader syntax.vader tsx.vader" || die
}

src_install() {
	vim-plugin_src_install ctags UltiSnips
}
