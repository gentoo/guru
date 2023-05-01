# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="A tool for the removal of TrueType instruction sets (hints) in fonts"
HOMEPAGE="https://github.com/source-foundry/dehinter"
SRC_URI="https://github.com/source-foundry/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="dev-python/fonttools[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
