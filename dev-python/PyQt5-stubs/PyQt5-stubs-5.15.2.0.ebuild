# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11,12} )

inherit distutils-r1

DESCRIPTION="Stubs for PyQt5"
HOMEPAGE="
	https://pypi.org/project/PyQt5-stubs/
	https://github.com/python-qt-tools/PyQt5-stubs

"

# no tests on pypi
SRC_URI="https://github.com/python-qt-tools/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="test? (
		dev-python/mypy[${PYTHON_USEDEP}]
		dev-python/PyQt5[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
