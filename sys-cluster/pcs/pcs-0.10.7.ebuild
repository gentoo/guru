# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend
USE_RUBY="ruby25 ruby26"
inherit distutils-r1 ruby-ng systemd

DESCRIPTION="Pacemaker/Corosync Configuration System"
HOMEPAGE="https://github.com/ClusterLabs/pcs"
SRC_URI="https://github.com/ClusterLabs/pcs/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="snmp systemd"

DEPEND="
	dev-libs/libffi
	media-libs/fontconfig
	sys-apps/coreutils
"
RDEPEND="
	${DEPEND}
	dev-libs/openssl
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/dacite[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pycurl[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	>=sys-cluster/corosync-3.0
	>=sys-cluster/pacemaker-2.0
	sys-libs/pam
	sys-process/psmisc
	>=www-servers/tornado-6.0[${PYTHON_USEDEP}]
	<www-servers/tornado-7.0[${PYTHON_USEDEP}]
"

ruby_add_rdepend "
	dev-ruby/backports
	dev-ruby/bundler
	dev-ruby/ethon
	dev-ruby/highline
	dev-ruby/json
	dev-ruby/multi_json
	dev-ruby/open4
	dev-ruby/rack
	dev-ruby/rack-protection
	dev-ruby/rack-test
	dev-ruby/rubygems
	dev-ruby/sinatra
	www-servers/thin
	dev-ruby/thor
	dev-ruby/tilt
"

PATCHES=( "${FILESDIR}/remove-ruby-bundle-path.patch" "${FILESDIR}/openrc-0.10.7.patch" )

S="${WORKDIR}/all/${P}"

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
		PREFIX="${EPREFIX}/usr/" \
		BUNDLE_INSTALL_PYAGENTX=false \
		BUNDLE_TO_INSTALL=false \
		BUILD_GEMS=false

	# mark log directories to be kept
	keepdir /var/log/pcsd
	keepdir /var/lib/pcsd

	# symlink the /usr/lib/pcs/pcs to /usr/sbin/pcs for pcsd
	dosym ../../sbin/pcs "${EPREFIX}/usr/lib/pcs/pcs"

	# use Debian style systemd unit (with config in /etc/default/pcsd)
	if use systemd ; then
		systemd_newunit "${S}/pcsd/pcsd.service.debian" "pcsd.service"
		systemd_newunit "${S}/pcsd/pcsd-ruby.service" "pcsd-daemon.service"
	fi
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

	python_foreach_impl python_optimize
}
