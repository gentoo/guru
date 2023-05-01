# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_10 )
USE_RUBY="ruby27"

inherit autotools systemd python-single-r1 ruby-ng

DESCRIPTION="Pacemaker/Corosync Configuration System"
HOMEPAGE="https://github.com/ClusterLabs/pcs"
SRC_URI="https://github.com/ClusterLabs/pcs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/all/${P}"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT=0

DEPEND="
	dev-libs/libffi
	sys-apps/coreutils
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/dacite[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/pycurl[${PYTHON_USEDEP}]
		dev-python/pyparsing[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		>=dev-python/tornado-6.0[${PYTHON_USEDEP}]
		<dev-python/tornado-7.0[${PYTHON_USEDEP}]
		dev-python/pyagentx[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/setuptools-scm[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
	')
	>=sys-cluster/corosync-3.0
	>=sys-cluster/pacemaker-2.1.0
	sys-libs/pam
	sys-process/psmisc
"

ruby_add_rdepend "
		dev-ruby/bundler
		dev-ruby/rubygems
		dev-ruby/backports
		dev-ruby/power_assert
		dev-ruby/daemons
		dev-ruby/ethon
		dev-ruby/eventmachine
		dev-ruby/json
		dev-ruby/mustermann
		dev-ruby/open4
		dev-ruby/rack
		dev-ruby/rack-protection
		dev-ruby/rack-test
		dev-ruby/sinatra
		dev-ruby/test-unit
		dev-ruby/webrick
		www-servers/thin
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
PATCHES="
	${FILESDIR}/pcs-0.11-gentoo-support.patch
	${FILESDIR}/remove_bashism.patch
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf
}

src_compile() {
	return
}

src_install() {
	python-single-r1_pkg_setup

	local makeopts=(
		DESTDIR="${ED}"
	)

	emake install "${makeopts[@]}"

	# mark log directories to be kept
	keepdir /var/log/pcsd
	keepdir /var/lib/pcsd

	#fix statedir
	sed -i "${D}/usr/share/pcsd/pcsd" -e 's/\/var\/lib\/lib\//\/var\/lib\//g' || die

	# custom service file for openRC
	newinitd "${FILESDIR}/pcs-0.11.initd" pcs
	newinitd "${FILESDIR}/pcsd-0.11.initd" pcsd

	systemd_newunit "${S}/pcsd/pcsd.service.in" "pcs.service"
	systemd_newunit "${S}/pcsd/pcsd-ruby.service.in" "pcsd.service"

	python_optimize
}
