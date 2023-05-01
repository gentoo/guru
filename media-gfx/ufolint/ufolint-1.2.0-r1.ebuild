# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="UFO source format linter"
HOMEPAGE="
	https://pypi.org/project/ufolint/
	https://github.com/source-foundry/ufolint
"
SRC_URI="https://github.com/source-foundry/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-python/commandlines[${PYTHON_USEDEP}]
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/fs[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
