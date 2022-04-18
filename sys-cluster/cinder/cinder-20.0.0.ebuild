# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYP="${P/_rc/rc}"
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 linux-info systemd tmpfiles

DESCRIPTION="Cinder is the OpenStack Block storage service, a spin out of nova-volumes"
HOMEPAGE="
	https://launchpad.net/cinder
	https://opendev.org/openstack/cinder/
	https://pypi.org/project/cinder/
	https://github.com/openstack/cinder
"
SRC_URI="https://tarballs.openstack.org/${PN}/${MYP}.tar.gz"
KEYWORDS="~amd64"

LICENSE="Apache-2.0 GPL-2"
SLOT="0"
IUSE="test"

# qemu is needed for image conversion
RDEPEND="
	>=dev-python/pbr-5.8.0[${PYTHON_USEDEP}]
	>=dev-python/decorator-4.4.2[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.30.1[${PYTHON_USEDEP}]
	>=dev-python/greenlet-0.4.16[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.18.1[${PYTHON_USEDEP}]
	>=dev-python/iso8601-0.1.12[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth-4.2.1[${PYTHON_USEDEP}]
	>=dev-python/keystonemiddleware-9.1.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.5.2[${PYTHON_USEDEP}]
	>=dev-python/oauth2client-4.1.3[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-8.3.2[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-db-11.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-4.6.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-messaging-12.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-middleware-4.1.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-policy-3.8.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-privsep-2.6.2[${PYTHON_USEDEP}]
	>=dev-python/oslo-reports-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-rootwrap-6.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-4.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-service-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-upgradecheck-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.12.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-versionedobjects-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/osprofiler-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.4[${PYTHON_USEDEP}]
	>=dev-python/paramiko-2.7.2[${PYTHON_USEDEP}]
	>=dev-python/paste-3.4.3[${PYTHON_USEDEP}]
	>=dev-python/pastedeploy-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.7.2[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.4.7[${PYTHON_USEDEP}]
	>=dev-python/python-barbicanclient-5.0.1[${PYTHON_USEDEP}]
	>=dev-python/python-glanceclient-3.2.2[${PYTHON_USEDEP}]
	>=dev-python/python-keystoneclient-4.1.1[${PYTHON_USEDEP}]
	>=dev-python/python-novaclient-17.2.1[${PYTHON_USEDEP}]
	>=dev-python/python-swiftclient-3.10.1[${PYTHON_USEDEP}]
	>=dev-python/pytz-2020.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.25.1[${PYTHON_USEDEP}]
	>=dev-python/routes-2.4.1[${PYTHON_USEDEP}]
	>=dev-python/taskflow-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/rtslib-fb-2.1.74[${PYTHON_USEDEP}]
	>=dev-python/six-1.15.0[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-migrate-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/stevedore-3.2.2[${PYTHON_USEDEP}]
	>=dev-python/tabulate-0.8.7[${PYTHON_USEDEP}]
	>=dev-python/tenacity-6.3.1[${PYTHON_USEDEP}]
	>=dev-python/webob-1.8.6[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-vmware-3.10.0[${PYTHON_USEDEP}]
	>=dev-python/os-brick-5.2.0[${PYTHON_USEDEP}]
	>=dev-python/os-win-5.5.0[${PYTHON_USEDEP}]
	>=dev-python/tooz-2.7.1[${PYTHON_USEDEP}]
	>=dev-python/google-api-python-client-1.11.0[${PYTHON_USEDEP}]
	>=dev-python/castellan-3.7.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-3.1[${PYTHON_USEDEP}]
	>=dev-python/cursive-0.2.2[${PYTHON_USEDEP}]
	>=dev-python/zstd-1.4.5.1[${PYTHON_USEDEP}]
	>=dev-python/boto3-1.16.51[${PYTHON_USEDEP}]

	>=dev-python/sqlalchemy-1.4.23[${PYTHON_USEDEP}]

	acct-user/cinder
	acct-group/cinder
	app-emulation/qemu
	sys-fs/sysfsutils
"
DEPEND="
	${RDEPEND}
	app-admin/sudo
"
BDEPEND="
	test? (
		>=dev-python/ddt-1.4.4[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-4.5.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.4.0[${PYTHON_USEDEP}]
		>=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/psycopg-2.5.0[${PYTHON_USEDEP}]
	)
"

RESTRICT="!test? ( test )"

pkg_pretend() {
	linux-info_pkg_setup
	CONFIG_CHECK_MODULES+="SCSI_ISCSI_ATTRS ISCSI_TCP "
	if linux_config_exists; then
		for module in ${CONFIG_CHECK_MODULES}; do
			linux_chkconfig_present ${module} || ewarn "${module} needs to be enabled"
		done
	fi
}

python_prepare_all() {
	sed -i '/^hacking/d' test-requirements.txt || die
	# only used for docs
	sed -i '/^sphinx-feature-classification/d' requirements.txt || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	oslo-config-generator --config-file=tools/config/cinder-config-generator.conf || die
	oslopolicy-sample-generator --config-file=tools/config/cinder-policy-generator.conf || die
}

python_install_all() {
	distutils-r1_python_install_all
	keepdir /etc/cinder
	dodir /etc/cinder/rootwrap.d

	for svc in api backup scheduler volume; do
		newinitd "${FILESDIR}/cinder.initd" "cinder-${svc}"
		systemd_dounit "${FILESDIR}/openstack-cinder-${svc}.service"
	done

	insinto /etc/cinder
	insopts -m 0640 -o cinder -g cinder
	doins "etc/cinder/api-httpd.conf"
	doins "etc/cinder/logging_sample.conf"
	doins "etc/cinder/rootwrap.conf"
	doins "etc/cinder/api-paste.ini"
	doins "etc/cinder/resource_filters.json"
	doins "etc/cinder/cinder.conf.sample"
	doins "etc/cinder/policy.yaml.sample"
	insinto /etc/cinder/rootwrap.d
	doins "etc/cinder/rootwrap.d/volume.filters"

	dodir /var/log/cinder
	fowners cinder:cinder /var/log/cinder

	#add sudoers definitions for user cinder
	insinto /etc/sudoers.d/
	insopts -m 0440 -o root -g root
	newins "${FILESDIR}/cinder.sudoersd" cinder

	newtmpfiles "${FILESDIR}/cinder.tmpfile" cinder.conf

	insinto /etc/logrotate.d
	newins "${FILESDIR}/cinder.logrotate" cinder.conf

	rm -r "${ED}/usr/etc"
}

pkg_postinst() {
	tmpfiles_process cinder.conf
	elog "Cinder needs tgtd to be installed and running to work with iscsi"
	elog "it also needs 'include /var/lib/cinder/volumes/*' in /etc/tgt/targets.conf"
}
