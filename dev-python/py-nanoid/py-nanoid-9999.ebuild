# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 git-r3

DESCRIPTION="Python Nanoid"
HOMEPAGE="https://github.com/puyuan/py-nanoid https://pypi.org/project/nanoid"
EGIT_REPO_URI="https://github.com/puyuan/py-nanoid.git"

LICENSE="MIT"
SLOT="0"

distutils_enable_tests pytest
