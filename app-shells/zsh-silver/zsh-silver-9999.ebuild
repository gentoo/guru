# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Zsh plugin for silver"
HOMEPAGE="https://github.com/silver-prompt/zsh"

inherit git-r3
EGIT_REPO_URI="https://github.com/silver-prompt/zsh.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	app-shells/zsh
	app-shells/silver
"

DEPEND="${RDEPEND}"

src_install() {
	insinto /usr/share/zsh/site-contrib/zsh-silver
	doins silver.plugin.zsh

	einstalldocs
}

pkg_postinst() {
	elog
	elog "In order to use ${CATEGORY}/${PN} add"
	elog ". /usr/share/zsh/site-contrib/zsh-silver/silver.plugin.zsh"
	elog "at the end of your ~/.zshrc"
	elog
}
