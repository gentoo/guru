# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Directory listings for zsh with git features"
HOMEPAGE="https://github.com/supercrabtree/k"
SRC_URI="https://github.com/supercrabtree/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	>=app-shells/zsh-4.3.11
	>=dev-vcs/git-1.7.2
"

DOCS=( readme.md )

src_install() {
	dodir "/usr/share/zsh/plugins"
	insinto "/usr/share/zsh/plugins/${PN}"
	doins "${PN}.sh"
	einstalldocs
}

pkg_postinst() {
	einfo "To use this script,  load it into your  interactive  ZSH  session:"
	einfo "\tsource /usr/share/zsh/plugins/${PN}/${PN}.zsh"
}
