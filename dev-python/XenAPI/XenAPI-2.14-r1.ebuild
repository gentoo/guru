# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Xen API SDK, for communication with Citrix XenServer and Xen Cloud Platform"
HOMEPAGE="
	https://xenproject.org/developers/teams/xen-api
	https://github.com/xapi-project/xen-api
	https://pypi.org/project/XenAPI
"
SRC_URI="mirror://pypi/X/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
