# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Evernote CLI: CRUD for notes in cloud, in markdown"
HOMEPAGE="https://github.com/vitaly-zdanevich/geeknote"
SRC_URI="https://github.com/vitaly-zdanevich/$PN/archive/refs/tags/v$PV.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

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

RESTRICT="test"

distutils_enable_tests pytest

pkg_postinst() {
	einfo "Autocompletion plugin is already bundled in oh-my-zsh. To enable just configure plugin definition"
	einfo "plugins=( ... geeknote ...)"
	einfo "see more at https://github.com/s7anley/zsh-geeknote"
}
