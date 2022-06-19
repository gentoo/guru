# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Convert some HTML to Markdown"
HOMEPAGE="https://github.com/matthewwithanm/python-markdownify https://pypi.org/project/markdownify/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

BDEPEND="
	dev-python/flake8[${PYTHON_USEDEP}]
"
RDEPEND="
     dev-python/six[${PYTHON_USEDEP}]
     dev-python/beautifulsoup4[${PYTHON_USEDEP}]
"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

python_install() {
    rm -r "${BUILD_DIR}"/lib/tests || die
    distutils-r1_python_install
}

distutils_enable_tests pytest
