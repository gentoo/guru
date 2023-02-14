# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="scalable persistent components"
HOMEPAGE="https://github.com/zopefoundation/BTrees"
SRC_URI="https://github.com/zopefoundation/BTrees/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/BTrees-${PV}"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
# Too manu failures, not upstream, needs to be investigated
RESTRICT="test"

RDEPEND="
	dev-python/persistent[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	doc? (
		dev-python/repoze-sphinx-autointerface[${PYTHON_USEDEP}]
		dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/transaction[${PYTHON_USEDEP}]
		dev-python/zope-testrunner[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

distutils_enable_sphinx docs
distutils_enable_tests unittest

src_test(){
	cd "${S}/src/BTrees" || die
	distutils-r1_src_test
}
