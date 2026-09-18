# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=(python3_{12..14})

inherit distutils-r1 pypi

DESCRIPTION="Certbot plugin for authentication using Gandi LiveDNS"
HOMEPAGE="
	https://github.com/obynio/certbot-plugin-gandi/
	https://pypi.org/project/certbot-dns-gandi/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=app-crypt/certbot-0.31.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.32.4[${PYTHON_USEDEP}]
"
