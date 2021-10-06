# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYP="${P//_/}"
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1 linux-info udev

DESCRIPTION="Cloud computing fabric controller"
HOMEPAGE="
	https://launchpad.net/nova
	https://opendev.org/openstack/nova
	https://pypi.org/project/nova
"
SRC_URI="
	https://dev.gentoo.org/~prometheanfire/dist/openstack/nova/victoria/nova.conf.sample -> nova.conf.sample-${PV}
	https://tarballs.openstack.org/${PN}/${MYP}.tar.gz
"
S="${WORKDIR}/${MYP}"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="+compute compute-only iscsi +memcached +mysql +novncproxy openvswitch postgres +rabbitmq sqlite"

RDEPEND="
	>=dev-python/pbr-5.5.1[${PYTHON_USEDEP}]
	compute-only? (
		>=dev-python/sqlalchemy-1.4.13[${PYTHON_USEDEP}]
	)
	sqlite? (
		>=dev-python/sqlalchemy-1.4.13[sqlite,${PYTHON_USEDEP}]
	)
	mysql? (
		>=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.4.13[${PYTHON_USEDEP}]
	)
	postgres? (
		>=dev-python/psycopg-2.5.0[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.4.13[${PYTHON_USEDEP}]
	)
	>=dev-python/decorator-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.30.1[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.10[${PYTHON_USEDEP}]
	>=dev-python/keystonemiddleware-4.20.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/routes-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.7[${PYTHON_USEDEP}]
	>=dev-python/webob-1.8.2[${PYTHON_USEDEP}]
	>=dev-python/greenlet-0.4.15[${PYTHON_USEDEP}]
	>=dev-python/pastedeploy-1.5.0-r1[${PYTHON_USEDEP}]
	>=dev-python/paste-2.0.2[${PYTHON_USEDEP}]
	>=dev-python/prettytable-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-migrate-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.18[${PYTHON_USEDEP}]
	>=dev-python/netifaces-0.10.4[${PYTHON_USEDEP}]
	>=dev-python/paramiko-2.7.1[${PYTHON_USEDEP}]
	>=dev-python/iso8601-0.1.11[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/python-cinderclient-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth-3.16.0[${PYTHON_USEDEP}]
	>=dev-python/python-neutronclient-7.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-glanceclient-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.25.1[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/websockify-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-cache-1.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-4.4.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-8.6.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-3.1.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-4.4.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-reports-1.18.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-upgradecheck-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.8.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-db-10.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-rootwrap-5.8.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-messaging-10.3.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-policy-3.7.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-privsep-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-5.0.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-service-2.5.0[${PYTHON_USEDEP}]
	>=dev-python/rfc3986-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-middleware-3.31.0[${PYTHON_USEDEP}]
	>=dev-python/psutil-3.2.2[${PYTHON_USEDEP}]
	>=dev-python/oslo-versionedobjects-1.35.0[${PYTHON_USEDEP}]
	>=dev-python/os-brick-4.3.1[${PYTHON_USEDEP}]
	>=dev-python/os-resource-classes-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/os-traits-2.5.0[${PYTHON_USEDEP}]
	>=dev-python/os-vif-1.15.2[${PYTHON_USEDEP}]
	>=dev-python/os-win-5.4.0[${PYTHON_USEDEP}]
	>=dev-python/castellan-0.16.0[${PYTHON_USEDEP}]
	>=dev-python/microversion-parse-0.2.1[${PYTHON_USEDEP}]
	>=dev-python/os-xenapi-0.3.4[${PYTHON_USEDEP}]
	>=dev-python/tooz-1.58.0[${PYTHON_USEDEP}]
	>=dev-python/cursive-0.2.1[${PYTHON_USEDEP}]
	>=dev-python/pypowervm-1.1.15[${PYTHON_USEDEP}]
	>=dev-python/retrying-1.3.3[${PYTHON_USEDEP}]
	>=dev-python/os-service-types-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/taskflow-3.8.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/zVMCloudConnector-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/futurist-1.8.0[${PYTHON_USEDEP}]
	>=dev-python/openstacksdk-0.35.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
	dev-python/libvirt-python[${PYTHON_USEDEP}]
	app-emulation/libvirt[iscsi?]
	app-emulation/spice-html5
	novncproxy? ( www-apps/novnc )
	sys-apps/iproute2
	openvswitch? ( net-misc/openvswitch )
	rabbitmq? ( net-misc/rabbitmq-server )
	memcached? (
		net-misc/memcached
		>=dev-python/python-memcached-1.58
	)
	sys-fs/sysfsutils
	sys-fs/multipath-tools
	net-misc/bridge-utils
	compute? (
		app-cdr/cdrtools
		sys-fs/dosfstools
		app-emulation/qemu
	)
	iscsi? (
		sys-fs/lsscsi
		>=sys-block/open-iscsi-2.0.873-r1
	)
	acct-user/nova
	acct-group/nova
"
DEPEND="
	${RDEPEND}
	app-admin/sudo
	test? (
		>=dev-python/types-paramiko-0.1.3[${PYTHON_USEDEP}]
		>=dev-python/ddt-1.2.1[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/mock-3.0.0[${PYTHON_USEDEP}]
		dev-python/psycopg:2[${PYTHON_USEDEP}]
		>=dev-python/pymysql-0.8.0[${PYTHON_USEDEP}]
		>=dev-python/python-barbicanclient-4.5.2[${PYTHON_USEDEP}]
		>=dev-python/python-ironicclient-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.8.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/osprofiler-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/testresources-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/bandit-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/gabbi-1.35.0[${PYTHON_USEDEP}]
		>=dev-python/wsgi_intercept-1.7.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-vmware-3.6.0[${PYTHON_USEDEP}]
	)
"

REQUIRED_USE="
	!compute-only? ( || ( mysql postgres sqlite ) )
	compute-only? ( compute !rabbitmq !memcached !mysql !postgres !sqlite )
	test? ( mysql )
"
#PATCHES=(
#)

distutils_enable_tests pytest

pkg_setup() {
	linux-info_pkg_setup
	CONFIG_CHECK_MODULES="BLK_DEV_NBD VHOST_NET IP6_NF_FILTER IP6_NF_IPTABLES IP_NF_TARGET_REJECT \
	IP_NF_MANGLE IP_NF_TARGET_MASQUERADE NF_NAT_IPV4 IP_NF_FILTER IP_NF_IPTABLES \
	NF_CONNTRACK_IPV4 NF_DEFRAG_IPV4 NF_NAT_IPV4 NF_NAT NF_CONNTRACK NETFILTER_XTABLES \
	ISCSI_TCP SCSI_DH DM_MULTIPATH DM_SNAPSHOT"
	if linux_config_exists; then
		for module in ${CONFIG_CHECK_MODULES}; do
			linux_chkconfig_present ${module} || ewarn "${module} needs to be enabled in kernel"
		done
	fi
}

python_prepare_all() {
	sed -i '/^hacking/d' test-requirements.txt || die
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all

	if use !compute-only; then
		for svc in api conductor consoleauth network scheduler spicehtml5proxy xvpvncproxy; do
			newinitd "${FILESDIR}/nova.initd" "nova-${svc}"
		done
	fi
	use compute && newinitd "${FILESDIR}/nova.initd" "nova-compute"
	use novncproxy && newinitd "${FILESDIR}/nova.initd" "nova-novncproxy"

	diropts -m 0750 -o nova -g qemu
	dodir /var/log/nova /var/lib/nova/instances
	diropts -m 0750 -o nova -g nova

	insinto /etc/nova
	insopts -m 0640 -o nova -g nova
	newins "${DISTDIR}/nova.conf.sample-${PV}" "nova.conf.sample"
	doins "${FILESDIR}/nova-compute.conf"
	doins "${S}/etc/nova/"*
	# rootwrap filters
	insopts -m 0644
	insinto /etc/nova/rootwrap.d
	doins "etc/nova/rootwrap.d/compute.filters"

	# add sudoers definitions for user nova
	insinto /etc/sudoers.d/
	insopts -m 0600 -o root -g root
	doins "${FILESDIR}/nova-sudoers"

	if use iscsi ; then
		# Install udev rules for handle iscsi disk with right links under /dev
		udev_newrules "${FILESDIR}/openstack-scsi-disk.rules" 60-openstack-scsi-disk.rules

		insinto /etc/nova/
		doins "${FILESDIR}/scsi-openscsi-link.sh"
	fi
	rm -r "${ED}/usr/etc"
}

pkg_postinst() {
	if use iscsi ; then
		elog "iscsid needs to be running if you want cinder to connect"
	fi
}
