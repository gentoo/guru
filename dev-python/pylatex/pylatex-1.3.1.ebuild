# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="PyLaTeX"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

PYTHON_COMPAT=( python3_{6,7,8} )
inherit distutils-r1 eutils

DESCRIPTION="A Python library for creating LaTeX files and snippets"
HOMEPAGE="https://github.com/JelteF/PyLaTeX"
SRC_URI="https://github.com/JelteF/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_PN}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="
dev-python/ordered-set[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

distutils_enable_sphinx docs
distutils_enable_tests nose

DEPEND+="
test? (
	dev-python/quantities
	dev-python/matplotlib
	dev-python/numpy
)
"

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

pkg_postinst() {
	elog "Optional dependencies:"
	optfeature "matplotlib support" dev-python/matplotlib
	optfeature "numpy support" dev-python/numpy
	optfeature "quantities support" dev-python/quantities
}
