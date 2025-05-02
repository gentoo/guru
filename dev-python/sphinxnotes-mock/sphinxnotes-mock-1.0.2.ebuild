# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx extension for mocking directives and roles without modifying documents"
HOMEPAGE="
	https://github.com/sphinx-notes/mock
	https://pypi.org/project/sphinxnotes-mock/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]"
