# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vim-plugin

COMMIT="2cc00ba72929ea5f9456a26782db57fb4cc56a65"
DESCRIPTION="vim plugin: Enhanced Python syntax highlighting"
HOMEPAGE="https://github.com/vim-python/python-syntax"
SRC_URI="https://github.com/vim-python/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

VIM_PLUGIN_HELPFILES="python-syntax.txt"
DOCS=( AUTHORS README.md )

src_install() {
	einstalldocs

	insinto /usr/share/vim/vimfiles/
	doins -r doc
	doins -r syntax
}
