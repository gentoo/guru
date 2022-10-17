# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="fortls - Fortran Language Server"
HOMEPAGE="https://github.com/gnikit/fortls"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# Need to explore the list of test dependencies
RESTRICT="test"

RDEPEND="
	dev-python/json5[${PYTHON_USEDEP}]
"
