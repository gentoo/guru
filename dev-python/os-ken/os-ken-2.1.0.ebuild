# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="OpenStack Cinder brick library for managing local volume attaches"
HOMEPAGE="
	https://github.com/openstack/os-ken
	https://opendev.org/openstack/os-ken
	https://pypi.org/project/os-ken
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/os-ken-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/eventlet-0.22.0[${PYTHON_USEDEP}]
	>=dev-python/msgpack-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.18[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/ovs-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/routes-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/webob-1.8.2[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/hacking-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]

		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/ncclient[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		app-admin/sudo
	)
"

distutils_enable_tests nose
