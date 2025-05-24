# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="A language server for some specific Bash scripts"
HOMEPAGE="
	https://github.com/termux/termux-language-server
	https://pypi.org/project/termux-language-server
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/tree-sitter-bash[python,${PYTHON_USEDEP}]
	dev-python/lsp-tree-sitter[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
"
BDEPEND="test? ( ${RDEPEND} )"

distutils_enable_tests pytest
