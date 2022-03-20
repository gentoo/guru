# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYP="${P//_/}"
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="A HTTP service for managing, selecting, and claiming cloud resources"
HOMEPAGE="
	https://github.com/openstack/placement
	https://opendev.org/openstack/placement
"
SRC_URI="
	https://dev.gentoo.org/~prometheanfire/dist/openstack/placement/victoria/placement.conf.sample -> placement.conf.sample-${PV}
	https://tarballs.openstack.org/${PN}/openstack-${MYP}.tar.gz
"
KEYWORDS="~amd64"
S="${WORKDIR}/openstack-${MYP}"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="mysql postgres +sqlite"

RDEPEND="
	>=dev-python/pbr-3.1.1[${PYTHON_USEDEP}]
	>=dev-python/keystonemiddleware-4.18.0[${PYTHON_USEDEP}]
	>=dev-python/routes-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/webob-1.8.2[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.25.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-3.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-6.7.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-4.3.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-2.25.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-db-4.40.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-policy-3.7.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-middleware-3.31.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-upgradecheck-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/os-resource-classes-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/os-traits-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/microversion-parse-0.2.1[${PYTHON_USEDEP}]

	acct-user/placement
	acct-group/placement

	sqlite? (
		>=dev-python/sqlalchemy-1.2.19[${PYTHON_USEDEP}]
	)
	mysql? (
		>=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.2.19[${PYTHON_USEDEP}]
	)
	postgres? (
		>=dev-python/psycopg-2.5.0[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.2.19[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.5.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/gabbi-1.35.0[${PYTHON_USEDEP}]
		>=dev-python/cryptography-2.7[${PYTHON_USEDEP}]
		>=dev-python/wsgi_intercept-1.7.0[${PYTHON_USEDEP}]
	)
"

REQUIRED_USE="
	|| ( mysql postgres sqlite )
	test? ( mysql postgres )
"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all

	diropts -m 0750 -o placement -g placement
	insinto /etc/placement
	insopts -m 0640 -o placement -g placement
	newins "${DISTDIR}/placement.conf.sample-${PV}" placement.conf.sample

	dobin tools/mysql-migrate-db.sh
	dobin tools/postgresql-migrate-db.sh
}
