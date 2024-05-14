# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Walk paths and run things"
HOMEPAGE="https://github.com/omnilib/trailrunner"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pathspec[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests unittest
