# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_PEP517=flit
inherit distutils-r1

MY_PN=${PN#sphinxcontrib-}
DESCRIPTION="Extension to include jQuery on newer Sphinx releases"
HOMEPAGE="
	https://pypi.org/project/sphinxcontrib-jquery/
	https://github.com/sphinx-contrib/jquery
"
SRC_URI="https://github.com/sphinx-contrib/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/sphinx-testing[${PYTHON_USEDEP}]
	)
"

DOCS=( AUTHORS {CHANGES,README}.rst )

distutils_enable_tests pytest
