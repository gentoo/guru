# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Tools for manipulating and analyzing SVG Path objects and Bezier curves"
HOMEPAGE="https://github.com/mathandy/svgpathtools https://pypi.org/project/svgpathtools/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/svgwrite[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

EPYTEST_PLUGINS=( )
distutils_enable_tests pytest
