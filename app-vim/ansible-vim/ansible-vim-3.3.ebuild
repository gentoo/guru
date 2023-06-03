# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: sytax highlighting for Ansible's common file types"
HOMEPAGE="https://github.com/pearofducks/ansible-vim"
SRC_URI="https://github.com/pearofducks/ansible-vim/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT BSD"
KEYWORDS="~amd64"

src_install() {
	vim-plugin_src_install

	find "${ED}" -name "*LICENSE" -delete || die
}
