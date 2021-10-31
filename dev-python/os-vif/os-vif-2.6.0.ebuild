# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="OpenStack Cinder brick library for managing local volume attaches"
HOMEPAGE="
	https://github.com/openstack/os-vif
	https://opendev.org/openstack/os-vif
	https://launchpad.net/os-vif
	https://pypi.org/project/os-vif
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/os_vif-${PV}.tar.gz"
S="${WORKDIR}/os_vif-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.18[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-3.20.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-3.30.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
	>=dev-python/oslo-privsep-1.23.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-versionedobjects-1.28.0[${PYTHON_USEDEP}]
	>=dev-python/ovsdbapp-0.12.1[${PYTHON_USEDEP}]
	>=dev-python/pyroute2-0.5.2[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/debtcollector-1.19.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/oslotest-1.10.0[${PYTHON_USEDEP}]
		>=dev-python/ovs-2.9.2[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
