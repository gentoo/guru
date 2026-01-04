# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=(python3_{11..14})

inherit distutils-r1 pypi

DESCRIPTION="Certbot plugin for authentication using PowerAdmin."
HOMEPAGE="
	https://github.com/poweradmin/certbot-dns-poweradmin/
	https://www.poweradmin.org/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=app-crypt/certbot-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.32.5[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		>=dev-python/requests-mock-1.11.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-cov-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/mypy-1.13.0[${PYTHON_USEDEP}]
		>=dev-python/types-requests-2.32.4.20250913[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
