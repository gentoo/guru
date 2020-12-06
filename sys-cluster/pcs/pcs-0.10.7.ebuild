# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
#inherit distutils-r1
inherit python-utils-r1 systemd

DESCRIPTION="Pacemaker/Corosync Configuration System"
HOMEPAGE="https://github.com/ClusterLabs/pcs"
SRC_URI="https://github.com/ClusterLabs/pcs/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="snmp systemd"

DEPEND="media-libs/fontconfig
	>=dev-lang/ruby-2.2
	dev-ruby/rubygems
	dev-ruby/bundler
	dev-libs/libffi
	sys-apps/coreutils
"
RDEPEND="${DEPEND}
	>=www-servers/tornado-6.0
	<www-servers/tornado-7.0
	dev-python/python-dateutil
	dev-python/distro
	dev-python/dacite
	dev-python/lxml
	dev-python/pyopenssl
	dev-python/pycurl
	dev-python/pyparsing
	sys-process/psmisc
	dev-libs/openssl
	dev-ruby/open4
	dev-ruby/highline
	dev-ruby/json
	dev-ruby/multi_json
	dev-ruby/rack
	dev-ruby/rack-protection
	dev-ruby/rack-test
	dev-ruby/thor
	dev-ruby/ethon
	dev-ruby/thin
	dev-ruby/tilt
	dev-ruby/sinatra
	dev-ruby/open4
	dev-ruby/backports
	sys-libs/pam
	>=sys-cluster/corosync-3.0
	>=sys-cluster/pacemaker-2.0
"

REQUIRED_USE=${PYTHON_REQUIRED_USE}

PATCHES=( "${FILESDIR}/remove-ruby-bundle-path.patch" "${FILESDIR}/openrc-0.10.7.patch" )

src_compile() {
	return
}

src_install() {
	# pre-create directory that is needed by 'make install'
	dodir "/usr/lib/pcs"
	# install files using 'make install'
	emake install \
		SYSTEMCTL_OVERRIDE=$(use systemd) \
		DESTDIR="${D}" \
		CONF_DIR="/etc/default/" \
		PREFIX="/usr${EPREFIX}" \
		BUNDLE_INSTALL_PYAGENTX=false \
		BUNDLE_TO_INSTALL=false \
		BUILD_GEMS=false

	# mark log directories to be kept
	keepdir /var/log/pcsd
	keepdir /var/lib/pcsd

	# symlink the /usr/lib/pcs/pcs to /usr/sbin/pcs for pcsd
	dosym /usr/sbin/pcs "${EPREFIX}/usr/lib/pcs/pcs"

	# use Debian style systemd unit (with config in /etc/default/pcsd)
	systemd_newunit "${S}/pcsd/pcsd.service.debian" "pcsd.service"
	systemd_newunit "${S}/pcsd/pcsd-ruby.service" "pcsd-daemon.service"
	# custom service file for openRC
	newinitd "${FILESDIR}/pcsd.initd" pcsd || die
	newinitd "${FILESDIR}/pcsd-daemon.initd" pcsd-daemon || die

	# move config files to right places - we use debian-style /etc/default
	cp -a "${S}/pcs/settings.py.debian" "${D}/usr/lib/pcs/settings.py"
	cp -a "${S}/pcsd/settings.rb.debian" "${D}/usr/lib/pcsd/settings.rb"

	# unless support for SNMP was requested remove SNMP related files
	if ! use snmp; then
		rm -rf "${D}/usr/share/snmp"
		rm -rf "${D}/usr/lib64/python*/site-packages/pcs/snmp" #FIXME
		rm "${D}/usr/share/man/man8/pcs_snmp_agent.8"
		rm "${D}/usr/lib/pcs/pcs_snmp_agent"
		rm "${D}/etc/default/pcs_snmp_agent"
	fi
}
