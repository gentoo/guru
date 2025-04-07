# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Library to populate items using XPath and CSS with a convenient API"
HOMEPAGE="https://scrapy.org/"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64 ~arm64"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/itemadapter[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	>=dev-python/parsel-1.8.1[${PYTHON_USEDEP}]
	dev-python/w3lib[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
