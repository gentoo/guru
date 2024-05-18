# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools

inherit bash-completion-r1 distutils-r1 git-r3

DESCRIPTION="Evernote CLI: CRUD for notes in cloud, in markdown"
HOMEPAGE="https://github.com/vitaly-zdanevich/geeknote"
EGIT_REPO_URI="https://github.com/vitaly-zdanevich/geeknote"

LICENSE="GPL-3"
SLOT="0"

BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
)"

RDEPEND="
	dev-python/evernote2[${PYTHON_USEDEP}]
	dev-python/html2text[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/markdown2[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/thrift[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${P}-remove_completion_from_setup.patch" )

RESTRICT="test"

# python_install_all() {
# 	dobashcomp completion/bash_completion/_geeknote
# 	insinto /usr/share/zsh/site-functions
# 	doins completion/zsh_completion/_geeknote
# 	distutils-r1_python_install_all
# }

distutils_enable_tests pytest

pkg_postinst() {
	einfo "Autocompletion plugin is already bundled in oh-my-zsh. To enable just configure plugin definition"
	einfo "plugins=( ... geeknote ...)"
	einfo "see more at https://github.com/s7anley/zsh-geeknote"
}
