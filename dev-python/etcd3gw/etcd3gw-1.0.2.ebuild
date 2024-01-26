# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 pypi

DESCRIPTION="A python client for etcd3 grpc-gateway v3 API"
HOMEPAGE="
	https://opendev.org/openstack/etcd3gw
	https://pypi.org/project/etcd3gw/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-2.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.20.0[${PYTHON_USEDEP}]
	>=dev-python/futurist-0.16.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/subunit-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/oslotest-1.10.0[${PYTHON_USEDEP}]
		>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/nose-1.3.7[${PYTHON_USEDEP}]
		>=dev-python/pytest-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/urllib3-1.15.1[${PYTHON_USEDEP}]
		>=dev-util/pifpaf-0.10.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
