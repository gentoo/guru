# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYP="${P//_/}"
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 linux-info systemd tmpfiles

DESCRIPTION="A virtual network service for Openstack"
HOMEPAGE="
	https://launchpad.net/neutron
	https://opendev.org/openstack/neutron
	https://pypi.org/project/neutron/
"
SRC_URI="https://tarballs.openstack.org/${PN}/${MYP}.tar.gz"
S="${WORKDIR}/${MYP}"

KEYWORDS=""
LICENSE="Apache-2.0"
SLOT="0"
IUSE="compute-only dhcp haproxy ipv6 l3 metadata openvswitch linuxbridge server sqlite +mysql postgres"

RDEPEND="
	>=dev-python/pbr-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/paste-2.0.2[${PYTHON_USEDEP}]
	>=dev-python/pastedeploy-1.5.0-r1[${PYTHON_USEDEP}]
	>=dev-python/routes-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/debtcollector-1.19.0[${PYTHON_USEDEP}]
	>=dev-python/decorator-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.26.1[${PYTHON_USEDEP}]
	>=dev-python/pecan-1.3.2[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.9.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.10[${PYTHON_USEDEP}]
	>=dev-python/keystonemiddleware-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.18[${PYTHON_USEDEP}]
	>=dev-python/netifaces-0.10.4[${PYTHON_USEDEP}]
	>=dev-python/neutron-lib-2.20.0[${PYTHON_USEDEP}]
	>=dev-python/python-neutronclient-7.8.0[${PYTHON_USEDEP}]
	>=dev-python/tenacity-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/webob-1.8.2[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth-3.14.0[${PYTHON_USEDEP}]
	>=dev-python/alembic-1.6.5[${PYTHON_USEDEP}]
	>=dev-python/stevedore-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-cache-1.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-3.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-8.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-db-4.44.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.20.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-messaging-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-middleware-3.31.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-policy-3.10.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-privsep-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-reports-1.18.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-rootwrap-5.15.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-2.25.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-service-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-upgradecheck-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.8.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-versionedobjects-1.35.1[${PYTHON_USEDEP}]
	>=dev-python/osprofiler-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/os-ken-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/os-resource-classes-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/ovs-2.10.0[${PYTHON_USEDEP}]
	>=dev-python/ovsdbapp-1.15.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.4[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.3.0[${PYTHON_USEDEP}]
	>=dev-python/pyroute2-0.6.4[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-17.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-novaclient-9.1.0[${PYTHON_USEDEP}]
	>=dev-python/openstacksdk-0.31.2[${PYTHON_USEDEP}]
	>=dev-python/python-designateclient-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/os-vif-1.15.1[${PYTHON_USEDEP}]
	>=dev-python/futurist-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/tooz-1.58.0[${PYTHON_USEDEP}]

	compute-only? (
		>=dev-python/sqlalchemy-1.3.23[${PYTHON_USEDEP}]
	)
	dhcp? ( net-dns/dnsmasq[dhcp-tools] )
	haproxy? ( net-proxy/haproxy )
	ipv6? (
		net-misc/radvd
		>=net-misc/dibbler-1.0.1
	)
	mysql? (
		>=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.3.23[${PYTHON_USEDEP}]
	)
	openvswitch? ( net-misc/openvswitch )
	postgres? (
		>=dev-python/psycopg-2.5.0[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.3.23[${PYTHON_USEDEP}]
	)
	sqlite? (
		>=dev-python/sqlalchemy-1.3.23[sqlite,${PYTHON_USEDEP}]
	)

	acct-group/neutron
	acct-user/neutron
	dev-python/pyudev[${PYTHON_USEDEP}]
	net-misc/bridge-utils
	net-misc/iputils[arping]
	net-firewall/conntrack-tools
	net-firewall/ebtables
	net-firewall/ipset
	net-firewall/iptables
	sys-apps/iproute2
"
DEPEND="
	${RDEPEND}
	app-admin/sudo
"
BDEPEND="
	test? (
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/testresources-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/webtest-2.0.27[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/ddt-1.0.1[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

REQUIRED_USE="
	!compute-only? (
		|| ( mysql postgres sqlite )
	)
	compute-only? (
		!mysql !postgres !sqlite !dhcp !l3 !metadata !server
		|| ( openvswitch linuxbridge )
	)
	test? ( mysql )
"

pkg_pretend() {
	linux-info_pkg_setup
	CONFIG_CHECK_MODULES="VLAN_8021Q IP6_NF_FILTER IP6_NF_IPTABLES IP_NF_TARGET_REJECT \
	IP_NF_MANGLE IP_NF_TARGET_MASQUERADE NF_NAT_IPV4 NF_DEFRAG_IPV4 NF_NAT NF_CONNTRACK \
	IP_NF_FILTER IP_NF_IPTABLES NETFILTER_XTABLES"
	if linux_config_exists; then
		for module in ${CONFIG_CHECK_MODULES}; do
			linux_chkconfig_present ${module} || ewarn "${module} needs to be enabled in kernel"
		done
	fi
}

pkg_config() {
	fperms 0700 /var/log/neutron
	fowners neutron:neutron /var/log neutron
}

src_prepare() {
	sed -i '/^hacking/d' test-requirements.txt || die
	# it's /bin/ip not /sbin/ip
	sed -i 's/sbin\/ip\,/bin\/ip\,/g' etc/neutron/rootwrap.d/* || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	./tools/generate_config_file_samples.sh || die
	oslopolicy-sample-generator --config-file=etc/oslo-policy-generator/policy.conf || die
}

python_install_all() {
	distutils-r1_python_install_all

	newinitd "${FILESDIR}/neutron.initd" "neutron-server"
	newconfd "${FILESDIR}/neutron-server.confd" "neutron-server"
	dosym ../../plugin.ini /etc/neutron/plugins/ml2/ml2_conf.ini
	newinitd "${FILESDIR}/neutron.initd" "neutron-dhcp-agent"
	newconfd "${FILESDIR}/neutron-dhcp-agent.confd" "neutron-dhcp-agent"
	newinitd "${FILESDIR}/neutron.initd" "neutron-l3-agent"
	newconfd "${FILESDIR}/neutron-l3-agent.confd" "neutron-l3-agent"
	newinitd "${FILESDIR}/neutron.initd" "neutron-metadata-agent"
	newconfd "${FILESDIR}/neutron-metadata-agent.confd" "neutron-metadata-agent"
	newinitd "${FILESDIR}/neutron.initd" "neutron-openvswitch-agent"
	newconfd "${FILESDIR}/neutron-openvswitch-agent.confd" "neutron-openvswitch-agent"
	newinitd "${FILESDIR}/neutron.initd" "neutron-ovs-cleanup"
	newconfd "${FILESDIR}/neutron-openvswitch-agent.confd" "neutron-ovs-cleanup"
	newinitd "${FILESDIR}/neutron.initd" "neutron-linuxbridge-agent"
	newconfd "${FILESDIR}/neutron-linuxbridge-agent.confd" "neutron-linuxbridge-agent"

	for svc in {dhcp,l3,linuxbridge,metadata,metering}_agent {linuxbridge,netns,ovs}_cleanup server ; do
		systemd_dounit "${FILESDIR}/openstack-neutron-${svc}.service"
	done

	diropts -m 755 -o neutron -g neutron
	dodir /var/log/neutron /var/lib/neutron
	keepdir /etc/neutron
	insinto /etc/neutron
	insopts -m 0640 -o neutron -g neutron

	insinto /etc/neutron
	doins etc/api-paste.ini
	doins etc/policy.yaml.sample

	for i in l3 dhcp metadata metering neutron_ovn_metadata ; do
		doins "etc/${i}_agent.ini.sample"
	done

	doins "etc/neutron.conf.sample"
	doins "etc/neutron/ovn.ini.sample"

	doins -r "etc/neutron/plugins"
	insopts -m 0640 -o root -g root
	doins "etc/rootwrap.conf"
	doins -r "etc/neutron/rootwrap.d"

	newtmpfiles "${FILESDIR}/neutron.tmpfile" neutron.conf

	insinto /etc/logrotate.d
	newins "${FILESDIR}/neutron.logrotate" neutron.conf

	#add sudoers definitions for user neutron
	insinto /etc/sudoers.d/
	insopts -m 0440 -o root -g root
	newins "${FILESDIR}/neutron.sudoersd" neutron

	# correcting perms
	fowners neutron:neutron -R "/etc/neutron"
	fperms o-rwx -R "/etc/neutron/"

	#remove superfluous stuff
	rm -R "${D}/usr/etc/"
}

python_install() {
	distutils-r1_python_install
	# copy migration conf file (not coppied on install via setup.py script)
	python_moduleinto neutron/db/migration/alembic_migrations
	python_domodule "neutron/db/migration/alembic_migrations/versions"
}

pkg_postinst() {
	elog
	elog "neutron-server's conf.d file may need updating to include additional ini files"
	elog "We currently assume the ml2 plugin will be used but do not make assumptions"
	elog "on if you will use openvswitch or linuxbridge (or something else)"
	elog
	elog "Other conf.d files may need updating too, but should be good for the default use case"
	elog
}
