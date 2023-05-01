# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Xen API SDK, for communication with Citrix XenServer and Xen Cloud Platform"
HOMEPAGE="
	https://xenproject.org/developers/teams/xen-api/
	https://github.com/xapi-project/xen-api
	https://pypi.org/project/XenAPI/
"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
