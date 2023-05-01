# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Auto-generate Sphinx API docs from Zope interfaces"
HOMEPAGE="https://github.com/repoze/repoze.sphinx.autointerface/"
SRC_URI="https://github.com/repoze/repoze.sphinx.autointerface/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/repoze.sphinx.autointerface-${PV}"

LICENSE="BSD-with-disclosure"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/zope-interface[${PYTHON_USEDEP}]
	test? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/zope-testrunner[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

distutils_enable_tests unittest

src_prepare() {
	# strip rdep specific to namespaces
	sed -i -e "/'setuptools'/d" setup.py || die
	distutils-r1_src_prepare
}

python_compile() {
	distutils-r1_python_compile
	find "${BUILD_DIR}" -name '*.pth' -delete || die
}
