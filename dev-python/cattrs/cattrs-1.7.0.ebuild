# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{8..9} pypy3 )

inherit distutils-r1

SRC_URI="https://github.com/Tinche/cattrs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Complex custom class converters for attrs"
HOMEPAGE="https://github.com/Tinche/cattrs"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/attrs[${PYTHON_USEDEP}]"
DEPEND="
	${RDEPEND}
	test? ( dev-python/hypothesis[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
distutils_enable_sphinx docs
