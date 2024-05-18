# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A simple code complexity analyser, supports most of the popular languages."
HOMEPAGE="http://www.lizard.ws/"
SRC_URI="https://github.com/terryyin/lizard/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	test? (
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${P}-py3.11.patch" "${FILESDIR}/${P}-py3.12.patch" )

distutils_enable_tests pytest
