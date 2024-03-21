# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Python Nanoid"
HOMEPAGE="https://github.com/puyuan/py-nanoid https://pypi.org/project/nanoid"
EGIT_REPO_URI="https://github.com/puyuan/py-nanoid.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/flake8[${PYTHON_USEDEP}]
"
DEPEND="${BDEPEND}"

distutils_enable_tests pytest
