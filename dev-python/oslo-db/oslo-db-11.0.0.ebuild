# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=bdepend
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="OpenStack Common DB Code"
HOMEPAGE="
	https://pypi.org/project/oslo.db
	https://opendev.org/openstack/oslo.db
	https://launchpad.net/oslo.db
"
SRC_URI="mirror://pypi/${PN:0:1}/oslo.db/oslo.db-${PV}.tar.gz"
S="${WORKDIR}/oslo.db-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+sqlite mysql postgres"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/alembic-0.9.6[${PYTHON_USEDEP}]
	>=dev-python/debtcollector-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-5.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	sqlite? (
		>=dev-python/sqlalchemy-1.4.0[sqlite,${PYTHON_USEDEP}]
	)
	mysql? (
		>=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.4.0[sqlite,${PYTHON_USEDEP}]
	)
	postgres? (
		>=dev-python/psycopg-2.8[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.4.0[sqlite,${PYTHON_USEDEP}]
	)
	>=dev-python/sqlalchemy-migrate-0.11.0[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.20.0[${PYTHON_USEDEP}]
"

DEPEND="
	${RDEPEND}
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.18.2[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-context-2.19.2[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/bandit-1.6.0[${PYTHON_USEDEP}]
		>=dev-python/pifpaf-0.10.0[${PYTHON_USEDEP}]
		>=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/psycopg-2.8.0[${PYTHON_USEDEP}]
	)
"

REQUIRED_USE="
	|| ( mysql postgres sqlite )
	test? ( mysql )
"

distutils_enable_tests pytest

python_prepare_all() {
	sed -i '/^testresources/d' requirements.txt || die
	sed -i '/^testscenarios/d' requirements.txt || die
	distutils-r1_python_prepare_all
}
