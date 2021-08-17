# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_SETUPTOOLS=pyproject.toml
inherit distutils-r1 desktop

DESCRIPTION="A simple sentence mining tool written in PyQt5"
HOMEPAGE="https://github.com/FreeLanguageTools/ssmtool/ https://pypi.org/project/ssmtool/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/simplemma[${PYTHON_USEDEP}]
	~dev-python/googletrans-4.0.0_rc1[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/bidict[${PYTHON_USEDEP}]
	dev-python/pystardict[${PYTHON_USEDEP}]
"

python_prepare_all () {
	# sed to remove the data_files option, which are necessary to include
	# data files in the packaged version, but will install files into
	# /usr/data if not removed before converting it to setup.py
	sed -i -e '/options\.data_files/,+4d' setup.cfg || die
	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install
	newicon icon.png ssmtool.png
	domenu ssmtool.desktop
}
