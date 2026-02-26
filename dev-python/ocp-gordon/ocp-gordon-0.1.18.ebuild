# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
PYPI_PN="ocp_gordon"
inherit distutils-r1 pypi

DESCRIPTION="Gordon surface fitting for OCP (Open CASCADE Python bindings)"
HOMEPAGE="https://github.com/snoyer/ocp-gordon https://pypi.org/project/ocp-gordon/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/cadquery-ocp-novtk-7.8[${PYTHON_USEDEP}]
	>=dev-python/numpy-2[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"

EPYTEST_PLUGINS=( )
distutils_enable_tests pytest
