# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="For iCloud: Devices, Find My iPhone, Status, Play Sound, Lost Mode, Contacts"
HOMEPAGE="https://github.com/timlaing/pyicloud https://pypi.org/project/pyicloud"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.rst"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]
	dev-python/keyrings-alt[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
