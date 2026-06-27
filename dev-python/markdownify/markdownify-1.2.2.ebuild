# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_PN="python-markdownify"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Convert HTML to Markdown"
HOMEPAGE="
	https://pypi.org/project/markdownify/
	https://github.com/matthewwithanm/python-markdownify
"
SRC_URI="
	https://github.com/matthewwithanm/${MY_PN}/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"
S="${WORKDIR}/${MY_P}/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="
	>=dev-python/beautifulsoup4-4.9[${PYTHON_USEDEP}]
	>=dev-python/six-1.15[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
