# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit readme.gentoo-r1 vim-plugin

COMMIT="c18071e5c7790928b763c2e88c487dfc93d84a15"
DESCRIPTION="vim plugin: Rainbow Parentheses Improved"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=4176
https://github.com/luochen1990/rainbow"
SRC_URI="https://github.com/luochen1990/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"

VIM_PLUGIN_HELPFILES="rainbow"

src_install() {
	vim-plugin_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	vim-plugin_pkg_postinst
	readme.gentoo_print_elog
}
