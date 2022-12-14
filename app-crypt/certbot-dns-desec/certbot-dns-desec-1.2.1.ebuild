# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="deSEC DNS Authenticator plugin for Certbot"
HOMEPAGE="
	https://pypi.org/project/certbot-dns-desec/
	https://github.com/desec-io/certbot-dns-desec
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-crypt/certbot[${PYTHON_USEDEP}]
"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/requests-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
