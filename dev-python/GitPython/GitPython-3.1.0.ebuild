# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="A python library used to interact with Git repositories"
HOMEPAGE="https://github.com/gitpython-developers/GitPython"
SRC_URI="https://github.com/gitpython-developers/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test" #requires git repository

RDEPEND="dev-python/gitdb[${PYTHON_USEDEP}]"

BDEPEND="test? ( dev-python/ddt[${PYTHON_USEDEP}] )"

distutils_enable_tests nose
distutils_enable_sphinx doc/source dev-python/sphinx_rtd_theme
