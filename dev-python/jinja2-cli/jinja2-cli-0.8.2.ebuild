# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="CLI for Jinja2"
HOMEPAGE="https://github.com/mattrobenolt/jinja2-cli"
SRC_URI="https://github.com/mattrobenolt/jinja2-cli/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]
"

src_prepare() {
	distutils-r1_src_prepare
}

python_install_all() {
	distutils-r1_python_install_all
}
