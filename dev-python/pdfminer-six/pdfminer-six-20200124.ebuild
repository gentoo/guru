# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
inherit distutils-r1

MY_PN="${PN/-/.}"

DESCRIPTION="Community maintained fork of pdfminer"
HOMEPAGE="https://github.com/pdfminer/pdfminer.six"
MY_GITHUB_AUTHOR="pdfminer"
SRC_URI="https://github.com/${MY_GITHUB_AUTHOR}/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	>=dev-python/chardet-3.0[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/sortedcontainers[${PYTHON_USEDEP}]
"
DEPEND="
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinx-argparse[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}"/"${MY_PN}-${PV}"

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}

distutils_enable_tests nose
