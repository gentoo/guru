# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=bdepend
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Messaging API for RPC and notifications over different messaging transports"
HOMEPAGE="
	https://pypi.org/project/oslo.messaging
	https://opendev.org/openstack/oslo.messaging
	https://launchpad.net/oslo.messaging
"
SRC_URI="mirror://pypi/${PN:0:1}/oslo.messaging/oslo.messaging-${PV}.tar.gz"
S="${WORKDIR}/oslo.messaging-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/futurist-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-5.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-3.36.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.37.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-service-1.24.0[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/debtcollector-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/cachetools-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/webob-1.7.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.13.0[${PYTHON_USEDEP}]
	>=dev-python/py-amqp-2.5.2[${PYTHON_USEDEP}]
	>=dev-python/kombu-4.6.6[${PYTHON_USEDEP}]
	>=dev-python/oslo-middleware-3.31.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-metrics-0.2.1[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/pifpaf-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/confluent-kafka-1.3.0[${PYTHON_USEDEP}]
		>=dev-python/pyngus-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/bandit-1.6.0[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.23.0[${PYTHON_USEDEP}]
		>=dev-python/greenlet-0.4.15[${PYTHON_USEDEP}]
	)
"

RESTRICT="test" # special setup is needed for tests

distutils_enable_tests pytest
