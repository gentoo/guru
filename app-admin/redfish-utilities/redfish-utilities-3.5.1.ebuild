# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{14..15} )

inherit distutils-r1 pypi

DESCRIPTION="Python based utilities for performing common management operations with Redfish"
HOMEPAGE="https://github.com/DMTF/Redfish-Tacklebox"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	>=dev-python/redfish-3.2.1[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/xlsxwriter-1.2.7[${PYTHON_USEDEP}]
"
