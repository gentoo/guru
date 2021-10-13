# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8,9} )

DOCS_BUILDER="sphinx"
DOCS_DIR="${S}/docs"
DOCS_DEPEND="dev-python/sphinx_rtd_theme"

inherit distutils-r1 docs

DESCRIPTION="PKCS#11 (Cryptoki) support for Python"
HOMEPAGE="
	https://github.com/danni/python-pkcs11
	https://pypi.org/project/python-pkcs11
"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#hardware device needed for tests
RESTRICT="test"

RDEPEND="
	>=dev-python/asn1crypto-1.0.0[${PYTHON_USEDEP}]
	dev-python/cached-property[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/oscrypto[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
