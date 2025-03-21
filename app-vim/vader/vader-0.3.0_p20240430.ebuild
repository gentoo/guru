# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

MY_PN="${PN}.vim"
COMMIT="429b669e6158be3a9fc110799607c232e6ed8e29"
DESCRIPTION="A simple Vimscript test framework"
HOMEPAGE="https://github.com/junegunn/vader.vim"
SRC_URI="https://github.com/junegunn/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="MIT"
KEYWORDS="~amd64"

VIM_PLUGIN_HELPFILES="vader"

src_install() {
	vim-plugin_src_install

	# make an isolated environment for running tests
	insinto /usr/share/${PN}
	doins -r autoload doc ftdetect ftplugin plugin syntax
}
