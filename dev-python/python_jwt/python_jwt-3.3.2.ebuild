# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Python module for generating and verifying JSON Web Tokens"
HOMEPAGE="
	https://github.com/davedoesdev/python-jwt
	https://pypi.org/project/python-jwt/
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/jwcrypto-1.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/gevent-1.2.2[${PYTHON_USEDEP}]
		>=dev-python/pyVows-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/mock-1.3.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
