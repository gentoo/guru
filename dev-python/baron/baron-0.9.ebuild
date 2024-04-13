# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Full Syntax Tree for python to make writing refactoring code a realist task"
HOMEPAGE="https://github.com/PyCQA/baron https://baron.pycqa.org"
SRC_URI="https://github.com/PyCQA/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/rply[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

# Doc building fails:
# RuntimeError: Non Expected warning in
# `/var/tmp/portage/dev-python/baron-0.9/work/baron-0.9/docs/advanced.rst` line 48
#distutils_enable_sphinx docs dev-python/matplotlib dev-python/ipython
