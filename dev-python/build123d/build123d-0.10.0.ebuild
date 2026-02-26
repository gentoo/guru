# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python parametric CAD modeling framework based on Open CASCADE"
HOMEPAGE="https://github.com/gumyr/build123d https://pypi.org/project/build123d/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# VTK is not available with cadquery-ocp-novtk
EPYTEST_DESELECT=(
	tests/test_direct_api/test_jupyter.py::TestJupyter::test_display_error
	tests/test_direct_api/test_jupyter.py::TestJupyter::test_repr_html
	tests/test_direct_api/test_vtk_poly_data.py::TestVTKPolyData::test_to_vtk_poly_data
)

RDEPEND="
	>=dev-python/cadquery-ocp-novtk-7.8[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-2[${PYTHON_USEDEP}]
	>=dev-python/svgpathtools-1.5.1[${PYTHON_USEDEP}]
	>=dev-python/anytree-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/ezdxf-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/ipython-8.0.0[${PYTHON_USEDEP}]
	>=dev-python/lib3mf-2.4.1[${PYTHON_USEDEP}]
	>=dev-python/ocpsvg-0.5[${PYTHON_USEDEP}]
	>=dev-python/ocp-gordon-0.1.17[${PYTHON_USEDEP}]
	dev-python/trianglesolver[${PYTHON_USEDEP}]
	dev-python/sympy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/webcolors[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	${RDEPEND}
"

EPYTEST_PLUGINS=( )
distutils_enable_tests pytest
