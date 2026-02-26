# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="SVG import and export for OCP (Open CASCADE) using svgelements"
HOMEPAGE="https://github.com/snoyer/ocpsvg https://pypi.org/project/ocpsvg/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/cadquery-ocp-novtk-7.8.1[${PYTHON_USEDEP}]
	>=dev-python/svgelements-1.9.1[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

EPYTEST_PLUGINS=( )
distutils_enable_tests pytest
