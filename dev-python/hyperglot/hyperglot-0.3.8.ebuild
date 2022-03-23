# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Detect language support for font binaries"
HOMEPAGE="
	http://hyperglot.rosettatype.com/
	https://github.com/rosettatype/hyperglot
	https://pypi.org/project/hyperglot/
"
SRC_URI="https://github.com/rosettatype/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+ OFL"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	>=dev-python/click-7.0[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.0.2[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.3[${PYTHON_USEDEP}]
	>=dev-python/unicodedata2-13.0.0[${PYTHON_USEDEP}]
	>=dev-python/colorlog-4.7.2[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
