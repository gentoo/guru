# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature vim-plugin

COMMIT="43e4d89c5d29b3a0d17dda5bd57eadda6fc614d4"
DESCRIPTION="vim plugin: Crystal language support"
HOMEPAGE="https://github.com/vim-crystal/vim-crystal"
SRC_URI="https://github.com/${PN}/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
KEYWORDS="~amd64"

src_install() {
	vim-plugin_src_install syntax_checkers
}

pkg_postinst() {
	optfeature "syntax checking support" app-vim/syntastic
}
