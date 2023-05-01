# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Detect language support for font binaries"
HOMEPAGE="
	https://hyperglot.rosettatype.com/
	https://pypi.org/project/hyperglot/
	https://github.com/rosettatype/hyperglot
"
SRC_URI="https://github.com/rosettatype/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	>=dev-python/click-7.0[${PYTHON_USEDEP}]
	>=dev-python/colorlog-4.7.2[${PYTHON_USEDEP}]
	>=dev-python/fonttools-4.0.2[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.3[${PYTHON_USEDEP}]
	>=dev-python/unicodedata2-13.0.0[${PYTHON_USEDEP}]
"

DOCS=( {CHANGELOG,README}.md CONTRIBUTORS.txt README{_comparison,_database}.md )

distutils_enable_tests pytest
