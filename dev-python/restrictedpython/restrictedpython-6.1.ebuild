# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A restricted execution environment for Python to run untrusted code"
HOMEPAGE="https://github.com/zopefoundation/RestrictedPython"
SRC_URI="https://github.com/zopefoundation/RestrictedPython/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/RestrictedPython-${PV}"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	doc? ( dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}] )
	test? ( dev-python/pytest-mock[${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}"

distutils_enable_sphinx docs
distutils_enable_tests pytest
