# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Distributed object middleware for Python (RPC)"
HOMEPAGE="
	https://pyro5.readthedocs.io
	https://pypi.org/project/Pyro5/
	https://github.com/irmen/Pyro5
"
SRC_URI="https://github.com/irmen/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/serpent-1.40[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source \
	dev-python/sphinx-rtd-theme

PROPERTIES="test_network"
RESTRICT="test"
