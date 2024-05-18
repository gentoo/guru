# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="A framework for managing your zsh configuration."
HOMEPAGE="https://ohmyz.sh"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

LICENSE="MIT"
SLOT="0"

DEPEND="app-shells/zsh"
RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/share/zsh/site-contrib/oh-my-zsh"
	doins -r *
}

pkg_postinst() {
	elog "In order to use ${PN}, copy /usr/share/zsh/site-contrib/oh-my-zsh/templates/zshrc.zsh-template over to your ~/.zshrc"
	elog "and change the path of your oh-my-zsh installation to: 'export ZSH=/usr/share/zsh/site-contrib/oh-my-zsh'"
}
