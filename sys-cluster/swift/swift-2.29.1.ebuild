# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 linux-info

DESCRIPTION="A highly available, distributed, and eventually consistent object/blob store"
HOMEPAGE="
	https://github.com/openstack/swift
	https://launchpad.net/swift
"
SRC_URI="https://tarballs.openstack.org/${PN}/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="account container doc +memcached +object proxy"

RDEPEND="
	>=dev-python/eventlet-0.25.0[${PYTHON_USEDEP}]
	>=dev-python/greenlet-0.3.2[${PYTHON_USEDEP}]
	>=dev-python/netifaces-0.8[${PYTHON_USEDEP}]
	>=dev-python/pastedeploy-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.4.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.14.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/xattr-0.4[${PYTHON_USEDEP}]
	>=dev-python/PyECLib-1.3.1[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.0.2[${PYTHON_USEDEP}]
	net-misc/rsync[xattr]
	acct-user/swift
	acct-group/swift

	memcached? ( net-misc/memcached )
"
DEPEND="
	${RDEPEND}
	dev-python/pbr[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/nosexcover-1.0.10[${PYTHON_USEDEP}]
		>=dev-python/nosehtmloutput-0.0.3[${PYTHON_USEDEP}]
		>=dev-python/mock-2.0[${PYTHON_USEDEP}]
		>=dev-python/python-swiftclient-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/boto-2.32.1[${PYTHON_USEDEP}]
		>=dev-python/boto3-1.9[${PYTHON_USEDEP}]
		>=dev-python/botocore-1.12[${PYTHON_USEDEP}]
		>=dev-python/requests-mock-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/keystonemiddleware-4.17.0[${PYTHON_USEDEP}]
	)
"

REQUIRED_USE="|| ( proxy account container object )"
RESTRICT="test" # tests run forever

distutils_enable_tests nose

pkg_pretend() {
	linux-info_pkg_setup
	CONFIG_CHECK="~EXT3_FS_XATTR ~SQUASHFS_XATTR ~CIFS_XATTR ~JFFS2_FS_XATTR
	~TMPFS_XATTR ~UBIFS_FS_XATTR ~EXT2_FS_XATTR ~REISERFS_FS_XATTR ~EXT4_FS_XATTR
	~ZFS"
	if linux_config_exists; then
		for module in ${CONFIG_CHECK}; do
			linux_chkconfig_present ${module} || ewarn "${module} needs to be enabled"
		done
	fi
}

src_prepare() {
	sed -i '/^hacking/d' test-requirements.txt || die
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	keepdir /etc/swift
	insinto /etc/swift

	newins "etc/swift.conf-sample" "swift.conf"
	newins "etc/rsyncd.conf-sample" "rsyncd.conf"
	newins "etc/mime.types-sample" "mime.types-sample"
	newins "etc/memcache.conf-sample" "memcache.conf-sample"
	newins "etc/drive-audit.conf-sample" "drive-audit.conf-sample"
	newins "etc/dispersion.conf-sample" "dispersion.conf-sample"

	if use proxy; then
		newinitd "${FILESDIR}/swift-proxy.initd" "swift-proxy"
		newins "etc/proxy-server.conf-sample" "proxy-server.conf"
		if use memcached; then
			sed -i '/depend/a\    need memcached' "${D}/etc/init.d/swift-proxy"
		fi
	fi
	if use account; then
		newinitd "${FILESDIR}/swift-account.initd" "swift-account"
		newins "etc/account-server.conf-sample" "account-server.conf"
	fi
	if use container; then
		newinitd "${FILESDIR}/swift-container.initd" "swift-container"
		newins "etc/container-server.conf-sample" "container-server.conf"
	fi
	if use object; then
		newinitd "${FILESDIR}/swift-object.initd" "swift-object"
		newins "etc/object-server.conf-sample" "object-server.conf"
		newins "etc/object-expirer.conf-sample" "object-expirer.conf"
	fi

	if use doc; then
		doman doc/manpages/*
		dodoc -r doc/{s3api,saio,source}
	fi

	fowners root:swift "/etc/swift"
	fperms 0750 /etc/swift
}

pkg_postinst() {
	elog "Openstack swift will default to using insecure http unless a"
	elog "certificate is created in /etc/swift/cert.crt and the associated key"
	elog "in /etc/swift/cert.key.  These can be created with the following:"
	elog "  * cd /etc/swift"
	elog "  * openssl req -new -x509 -nodes -out cert.crt -keyout cert.key"
}
