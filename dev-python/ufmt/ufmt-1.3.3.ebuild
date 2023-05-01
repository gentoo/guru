# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 pypi

DESCRIPTION="Safe, atomic formatting with black and usort"
HOMEPAGE="https://github.com/omnilib/ufmt/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/black-20.8.0[${PYTHON_USEDEP}]
	>=dev-python/moreorless-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/tomlkit-0.7.2[${PYTHON_USEDEP}]
	>=dev-python/trailrunner-1.2.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.0[${PYTHON_USEDEP}]
	>=dev-python/usort-1.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests unittest
