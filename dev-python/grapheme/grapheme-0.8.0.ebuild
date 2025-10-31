# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )
PYPI_PN="graphemeu"

inherit distutils-r1 pypi

DESCRIPTION="Unicode grapheme helpers"
HOMEPAGE="
	https://graphemeu.readthedocs.io/
	https://pypi.org/project/graphemeu/
	https://github.com/timendum/grapheme
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

distutils_enable_sphinx docs dev-python/alabaster
