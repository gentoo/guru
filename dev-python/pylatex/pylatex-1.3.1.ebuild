# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="PyLaTeX"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

PYTHON_COMPAT=( python3_{6,7,8} ) #python2_7 -> error: package directory 'python2_source/pylatex' does not exist
inherit distutils-r1

DESCRIPTION="A Python library for creating LaTeX files and snippets"
HOMEPAGE="https://github.com/JelteF/PyLaTeX"
SRC_URI="https://github.com/JelteF/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_PN}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples matplotlib numpy" # quantities can be used also, but is not a gentoo package.

DEPEND="
	dev-python/ordered-set[${PYTHON_USEDEP}]
	matplotlib? ( dev-python/matplotlib[$PYTHON_USEDEP] )
	numpy? ( dev-python/numpy[$PYTHON_USEDEP] )
"

RDEPEND="${DEPEND}"

distutils_enable_tests nose
distutils_enable_sphinx docs

src_prepare(){
	if use doc; then
		sphinx-apidoc -F -o docs "${S}"/pylatex # conf.py is not included in source
	fi

	distutils-r1_src_prepare
}

python_install_all() {
	if use examples ; then
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}

src_test() {
	rm "${S}"/tests/test_quantities.py # quantities is not a gentoo package
	distutils-r1_src_test
}
