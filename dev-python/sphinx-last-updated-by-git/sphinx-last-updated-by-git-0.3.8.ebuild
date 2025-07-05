# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION='Get the "last updated" time for each Sphinx page from Git'
HOMEPAGE="
	https://pypi.org/project/sphinx-last-updated-by-git/
	https://github.com/mgeier/sphinx-last-updated-by-git/
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/babel[${PYTHON_USEDEP}]
	>=dev-python/sphinx-1.8[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest-import-check )

# Tests require to clone a Git repo. While this can be worked around by using
# git-bundle, tests still fail because Sphinx makes some warnings fatal.
distutils_enable_tests import-check
