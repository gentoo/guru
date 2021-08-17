# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit readme.gentoo-r1 vim-plugin

COMMIT="4d15633cdaf61602e1d9fd216a77fc02e0881b2d"
DESCRIPTION="vim plugin: Rainbow Parentheses Improved"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=4176
https://github.com/luochen1990/rainbow"
SRC_URI="https://github.com/luochen1990/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"

VIM_PLUGIN_HELPFILES="rainbow"

src_install() {
	rm -r tests || die
	vim-plugin_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	vim-plugin_pkg_postinst
	readme.gentoo_print_elog
}
