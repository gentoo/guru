# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYP="${P/_rc/rc}"
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 linux-info systemd

DESCRIPTION="A CloudFormation-compatible openstack-native cloud orchestration engine"
HOMEPAGE="
	https://launchpad.net/heat
	https://opendev.org/openstack/heat/
	https://pypi.org/project/openstack-heat/
"
SRC_URI="https://tarballs.openstack.org/${PN}/openstack-${MYP}.tar.gz"
KEYWORDS="~amd64"
S="${WORKDIR}/openstack-${MYP}"

LICENSE="Apache-2.0 GPL-2"
SLOT="0"

RDEPEND="
	>=dev-python/pbr-3.1.1[${PYTHON_USEDEP}]
	>=dev-python/Babel-2.3.4[${PYTHON_USEDEP}]
	>=dev-python/ddt-1.4.1[${PYTHON_USEDEP}]
	>=dev-python/croniter-0.3.4[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.5[${PYTHON_USEDEP}]
	>=dev-python/debtcollector-1.19.0[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.18.2[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth-3.18.0[${PYTHON_USEDEP}]
	>=dev-python/keystonemiddleware-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.18[${PYTHON_USEDEP}]
	>=dev-python/neutron-lib-1.14.0[${PYTHON_USEDEP}]
	>=dev-python/openstacksdk-0.28.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-cache-1.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-6.8.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-3.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-db-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.20.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-4.3.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-messaging-5.29.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-middleware-3.31.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-policy-3.7.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-reports-1.18.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-2.25.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-service-1.24.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-upgradecheck-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/osprofiler-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-versionedobjects-1.31.2[${PYTHON_USEDEP}]
	>=dev-python/pastedeploy-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/aodhclient-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/python-barbicanclient-4.5.2[${PYTHON_USEDEP}]
	>=dev-python/python-blazarclient-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/python-cinderclient-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/python-designateclient-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/python-glanceclient-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/python-heatclient-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/python-ironicclient-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/python-keystoneclient-3.8.0[${PYTHON_USEDEP}]
	>=dev-python/python-magnumclient-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/python-manilaclient-1.16.0[${PYTHON_USEDEP}]
	>=dev-python/python-mistralclient-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-monascaclient-1.12.0[${PYTHON_USEDEP}]
	>=dev-python/python-neutronclient-6.14.0[${PYTHON_USEDEP}]
	>=dev-python/python-novaclient-9.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-octaviaclient-1.8.0[${PYTHON_USEDEP}]
	>=dev-python/python-openstackclient-3.12.0[${PYTHON_USEDEP}]
	>=dev-python/python-saharaclient-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/python-swiftclient-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/python-troveclient-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/python-vitrageclient-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/python-zaqarclient-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/python-zunclient-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/pytz-2013.6[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.23.0[${PYTHON_USEDEP}]
	>=dev-python/tenacity-6.1.0[${PYTHON_USEDEP}]
	>=dev-python/routes-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-migrate-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/stevedore-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/webob-1.7.1[${PYTHON_USEDEP}]
	>=dev-python/yaql-1.1.3[${PYTHON_USEDEP}]

	>=dev-python/sqlalchemy-1.0.10[${PYTHON_USEDEP}]

	acct-user/heat
	acct-group/heat
"
DEPEND="
	${RDEPEND}
	app-admin/sudo
"
BDEPEND="
	test? (
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/kombu-5.0.1[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/testresources-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/pygments-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/tempest-17.1.0[${PYTHON_USEDEP}]

		>=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	rm -r heat/tests/test_hacking.py || die
	sed -i '/^hacking/d' test-requirements.txt || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	oslo-config-generator --config-file=config-generator.conf || die
	oslopolicy-sample-generator --config-file etc/heat/heat-policy-generator.conf || die
}

python_install_all() {
	distutils-r1_python_install_all
	diropts -m 0750 -o heat -g heat
	keepdir /etc/heat
	dodir /etc/heat/environment.d
	dodir /etc/heat/templates

	for svc in api api-cfn engine; do
		newinitd "${FILESDIR}/heat.initd" "heat-${svc}"
	done

	insinto /etc/logrotate.d
	doins "${FILESDIR}/heat.logrotate"

	insinto /etc/heat
	insopts -m 0640 -o heat -g heat
	doins etc/heat/heat.conf.sample
	doins etc/heat/policy.yaml.sample
	doins "etc/heat/api-paste.ini"
	insinto /etc/heat/templates
	doins "etc/heat/templates/"*
	insinto /etc/heat/environment.d
	doins "etc/heat/environment.d/default.yaml"

	dodir /var/log/heat
	fowners heat:heat /var/log/heat
	keepdir /var/log/heat

	systemd_dounit "${FILESDIR}/heat-engine.service"
	systemd_dounit "${FILESDIR}/heat-api.service"

	rm -r "${ED}/usr/etc"
}
