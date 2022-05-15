# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit linux-info python-r1

DESCRIPTION="A openstack meta-package for installing the various openstack pieces"
HOMEPAGE="https://openstack.org"

LICENSE="metapackage"
SLOT="0"
IUSE="
	cinder glance heat keystone neutron nova placement swift
	compute dhcp haproxy infiniband ipv6 iscsi ldap lvm memcached mongo mysql novncproxy openvswitch postgres rabbitmq sqlite
"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="
	${PYTHON_DEPS}

	cinder? (
		sys-cluster/cinder[${PYTHON_USEDEP}]
		iscsi? (
			sys-block/tgt
			sys-block/open-iscsi
		)
		lvm? ( sys-fs/lvm2 )
		memcached? ( net-misc/memcached )
	)
	glance? ( app-admin/glance[${PYTHON_USEDEP}] )
	heat? ( sys-cluster/heat[${PYTHON_USEDEP}] )
	keystone? (
		sys-auth/keystone[${PYTHON_USEDEP}]
		|| (
			www-servers/uwsgi[python,${PYTHON_USEDEP}]
			www-apache/mod_wsgi[${PYTHON_USEDEP}]
			www-servers/gunicorn[${PYTHON_USEDEP}]
		)
		ldap? (
				>=dev-python/python-ldap-3.1.0[${PYTHON_USEDEP}]
				>=dev-python/ldappool-2.3.1[${PYTHON_USEDEP}]
		)
		memcached? ( >=dev-python/python-memcached-1.56[${PYTHON_USEDEP}] )
		mongo? ( >=dev-python/pymongo-3.0.2[${PYTHON_USEDEP}] )
	)
	neutron? (
		sys-cluster/neutron[${PYTHON_USEDEP}]
		dhcp? ( net-dns/dnsmasq[dhcp-tools] )
		haproxy? ( net-proxy/haproxy )
		ipv6? (
				net-misc/radvd
				>=net-misc/dibbler-1.0.1
		)
		openvswitch? ( net-misc/openvswitch )
	)
	nova? (
		sys-cluster/nova[${PYTHON_USEDEP}]
		compute? (
				app-cdr/cdrtools
				sys-fs/dosfstools
				app-emulation/qemu
		)
		memcached? (
				net-misc/memcached
				>=dev-python/python-memcached-1.58[${PYTHON_USEDEP}]
		)
		novncproxy? ( www-apps/novnc )
		openvswitch? ( net-misc/openvswitch )
		rabbitmq? ( net-misc/rabbitmq-server )
	)
	placement? ( sys-cluster/placement[${PYTHON_USEDEP}] )
	swift? (
		sys-cluster/swift[${PYTHON_USEDEP}]
		memcached? ( net-misc/memcached )
	)

	mysql? ( >=dev-python/pymysql-0.7.6[${PYTHON_USEDEP}] )
	postgres? ( >=dev-python/psycopg-2.5.0[${PYTHON_USEDEP}] )
	sqlite? ( >=dev-python/sqlalchemy-1.4.23[sqlite,${PYTHON_USEDEP}] )
"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	cinder? ( || ( mysql postgres sqlite ) )
	glance? ( || ( mysql postgres sqlite ) )
	heat? ( || ( mysql postgres sqlite ) )
	keystone? ( || ( mysql postgres sqlite ) )
	neutron? ( || ( mysql postgres sqlite ) )
	nova? ( || ( mysql postgres sqlite ) )
	placement? ( || ( mysql postgres sqlite ) )
"

pkg_pretend() {
		linux-info_pkg_setup
		CONFIG_CHECK_MODULES=""
#		if use tcp; then
#				CONFIG_CHECK_MODULES+="SCSI_ISCSI_ATTRS ISCSI_TCP "
#		fi
		if use infiniband; then
				CONFIG_CHECK_MODULES+="INFINIBAND_ISER "
				CONFIG_CHECK_MODULES+="INFINIBAND_IPOIB INFINIBAND_USER_MAD INFINIBAND_USER_ACCESS"
		fi
		if linux_config_exists; then
				for module in ${CONFIG_CHECK_MODULES}; do
						linux_chkconfig_present ${module} || ewarn "${module} needs to be enabled"
				done
		fi
}
