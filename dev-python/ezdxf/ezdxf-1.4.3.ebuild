# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python library for creating and manipulating DXF drawings"
HOMEPAGE="https://ezdxf.mozman.at/ https://github.com/mozman/ezdxf"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64 ~arm64"

# Tests require fonts from repository ./fonts folder
# https://github.com/mozman/ezdxf/blob/master/tests/README.md
RESTRICT="test"

RDEPEND="
	>=dev-python/pyparsing-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/fonttools[${PYTHON_USEDEP}]
"
BDEPEND="${RDEPEND}"
