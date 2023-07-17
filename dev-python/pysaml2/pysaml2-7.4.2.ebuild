# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="Python implementation of SAML Version 2 Standard"
HOMEPAGE="
	https://pypi.org/project/pysaml2/
	https://github.com/rohe/pysaml2
"
SRC_URI="https://github.com/IdentityPython/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/xmlsec[openssl]
	>=dev-python/cryptography-3.1[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	<dev-python/requests-3[${PYTHON_USEDEP}]
	>=dev-python/xmlschema-1.2.1[${PYTHON_USEDEP}]
"
# TODO: package 'repoze-who' for s2repoze tests
BDEPEND="
	test? (
		dev-python/pyasn1[${PYTHON_USEDEP}]
		<dev-python/pymongo-5[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/alabaster
