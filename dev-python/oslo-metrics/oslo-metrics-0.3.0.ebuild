# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="OpenStack library for collecting metrics from Oslo libraries"
HOMEPAGE="
	https://pypi.org/project/oslo.metrics
	https://opendev.org/openstack/oslo.metrics
	https://launchpad.net/oslo.metrics
"
SRC_URI="mirror://pypi/${PN:0:1}/oslo.metrics/oslo.metrics-${PV}.tar.gz"
S="${WORKDIR}/oslo.metrics-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-3.1.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.41.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-3.44.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-6.9.0[${PYTHON_USEDEP}]
	>=dev-python/prometheus_client-0.6.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/bandit-1.6.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
