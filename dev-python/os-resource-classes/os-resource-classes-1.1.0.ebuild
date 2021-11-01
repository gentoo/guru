# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A list of standardized resource classes for OpenStack"
HOMEPAGE="
	https://github.com/openstack/os-resource-classes
	https://opendev.org/openstack/os-resource-classes
	https://pypi.org/project/os-resource-classes
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pbr-2.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
	>=dev-python/oslotest-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/testtools-1.4.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
