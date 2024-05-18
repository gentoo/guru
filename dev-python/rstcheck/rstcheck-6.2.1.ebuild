# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Checks syntax of reStructuredText and code blocks nested within it"
HOMEPAGE="https://github.com/rstcheck/rstcheck"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/docutils[${PYTHON_USEDEP}]"
BDEPEND="
	>=dev-python/setuptools-scm-7.1.0[${PYTHON_USEDEP}]
"

# broken without dev-python/typer and dev-python/restcheck-core
RESTRICT="test"
