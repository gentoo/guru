# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A library to do [jobs, tasks, flows] in a HA manner using different backends"
HOMEPAGE="
	https://github.com/openstack/taskflow
	https://opendev.org/openstack/taskflow
	https://pypi.org/project/taskflow
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/futurist-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/fasteners-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/networkx-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/automaton-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-1.18.0[${PYTHON_USEDEP}]
	>=dev-python/tenacity-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/cachetools-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydot-1.2.4[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"
BDEPEND="
	test? (
		>=dev-python/kazoo-2.6.0[${PYTHON_USEDEP}]
		>=dev-python/kombu-4.3.0[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.18.2[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.0.10[${PYTHON_USEDEP}]
		>=dev-python/alembic-0.8.0[${PYTHON_USEDEP}]
		>=dev-python/SQLAlchemy-Utils-0.30.11[${PYTHON_USEDEP}]
		>=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/psycopg-2.8.0[${PYTHON_USEDEP}]
		>=dev-python/pydotplus-2.0.2[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]

	)
"

distutils_enable_tests pytest
