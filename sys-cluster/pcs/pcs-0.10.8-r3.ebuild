# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_10 )
USE_RUBY="ruby26 ruby27"

inherit python-single-r1 ruby-ng systemd

DESCRIPTION="Pacemaker/Corosync Configuration System"
HOMEPAGE="https://github.com/ClusterLabs/pcs"
SRC_URI="https://github.com/ClusterLabs/pcs/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/all/${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

DEPEND="
	dev-libs/libffi
	media-libs/fontconfig
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/distro[${PYTHON_USEDEP}]
		dev-python/dacite[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/pycurl[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/pyparsing[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		>=dev-python/tornado-6.0[${PYTHON_USEDEP}]
		<dev-python/tornado-7.0[${PYTHON_USEDEP}]
	')
	dev-libs/openssl
	>=sys-cluster/corosync-3.0
	>=sys-cluster/pacemaker-2.0.0
	<sys-cluster/pacemaker-2.1.0
	sys-libs/pam
	sys-process/psmisc
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
PATCHES=(
	"${FILESDIR}/remove-ruby-bundle-path.patch"
	"${FILESDIR}/openrc-${PV}.patch"
	"${FILESDIR}/pcsd-daemon.service.patch"
)

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
	dev-ruby/thor
	dev-ruby/tilt
	www-servers/thin
"

src_compile() {
	return
}

src_install() {
	python-single-r1_pkg_setup
	# pre-create directory that is needed by 'make install'
	dodir "/usr/lib/pcs"
	# install files using 'make install'

	local makeopts=(
		SYSTEMCTL_OVERRIDE=$(use systemd)
		DESTDIR="${D}"
		CONF_DIR="/etc/default/"
		PREFIX="${EPREFIX}/usr/"
		BUILD_GEMS=false
		BUNDLE_INSTALL_PYAGENTX=false
		BUNDLE_TO_INSTALL=false
	)
	emake install "${makeopts[@]}"

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
	# Remove Bundled systemd service
	rm "${D}"/usr/lib/systemd/system/pcsd-ruby.service || die
	rm "${D}"/usr/lib/systemd/system/pcsd.service || die

	# custom service file for openRC
	newinitd "${FILESDIR}/pcsd.initd" pcsd
	newinitd "${FILESDIR}/pcsd-daemon.initd" pcsd-daemon

	# move config files to right places - we use debian-style /etc/default
	cp -a "${S}/pcs/settings.py.debian" "${D}/usr/lib/pcs/settings.py" || die
	cp -a "${S}/pcsd/settings.rb.debian" "${D}/usr/lib/pcsd/settings.rb" || die

	python_optimize
}
