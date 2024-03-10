# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

HTML_DOCS=( docs )

inherit distutils-r1

DESCRIPTION="Python package for parsing and generating JSON feeds."
HOMEPAGE="https://github.com/lukasschwab/jsonfeed"
SRC_URI="https://github.com/lukasschwab/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/feedparser[${PYTHON_USEDEP}]"

python_prepare_all() {
	distutils-r1_python_prepare_all
	rm -rf "${S}/tests"
}
