# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="A client for the OpenStack Octavia API"
HOMEPAGE="
	https://opendev.org/openstack/python-octaviaclient
	https://github.com/openstack/python-octaviaclient/
	https://pypi.org/project/python-octaviaclient/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/cliff-4.7.0[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth1-3.18.0[${PYTHON_USEDEP}]
	>=dev-python/python-neutronclient-6.7.0[${PYTHON_USEDEP}]
	>=dev-python/python-openstackclient-3.12.0[${PYTHON_USEDEP}]
	>=dev-python/osc-lib-1.14.1[${PYTHON_USEDEP}]
	>dev-python/oslo-serialization-2.19.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	>dev-python/pbr-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.14.2[${PYTHON_USEDEP}]
"

src_prepare() {
	distutils-r1_src_prepare
}
