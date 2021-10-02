# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A py.test plugin providing fixtures and markers to simplify testing of asynchronous tornado applications"
HOMEPAGE="https://github.com/vidartf/pytest-tornado"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pytest-3.6[${PYTHON_USEDEP}]
	>=www-servers/tornado-5[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
