# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} pypy3  )
DISTUTILS_USE_SETUPTOOLS=pyproject.toml
inherit distutils-r1 desktop

DESCRIPTION="A simple sentence mining tool written in PyQt5"
HOMEPAGE="https://github.com/FreeLanguageTools/ssmtool/ https://pypi.org/project/ssmtool/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
DEPEND="
	dev-python/pymorphy2
	dev-python/pymorphy2-dicts-ru
	dev-python/PyQt5
	dev-python/beautifulsoup:4
"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

python_install() {
	newicon icon.png ssmtool.png
	domenu ssmtool.desktop
	distutils-r1_python_install
}

