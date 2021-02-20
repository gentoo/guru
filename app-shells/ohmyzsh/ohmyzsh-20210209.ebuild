# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == "9999" ]] ; then
		EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
		inherit git-r3
else
		MY_COMMIT="f21e646ce6c09198f7f625c597f08af49551fdb0"
		SRC_URI="https://github.com/${PN}/${PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="~amd64"
		S="${WORKDIR}/${PN}-${MY_COMMIT}"
fi

DESCRIPTION="A framework for managing your zsh configuration."
HOMEPAGE="https://ohmyz.sh"

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
