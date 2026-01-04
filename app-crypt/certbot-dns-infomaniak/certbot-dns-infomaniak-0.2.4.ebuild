# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=(python3_{11..14})

inherit distutils-r1 pypi

DESCRIPTION="Infomaniak DNS Authenticator plugin for Certbot"
HOMEPAGE="
	https://github.com/Infomaniak/certbot-dns-infomaniak/
	https://pypi.org/project/certbot-dns-infomaniak/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=app-crypt/certbot-0.31.0[${PYTHON_USEDEP}]
	>=dev-python/idna-3.10[${PYTHON_USEDEP}]
	>=dev-python/requests-2.32.4[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		>=dev-python/requests-mock-1.12.1[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
