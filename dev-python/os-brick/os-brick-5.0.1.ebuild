# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="OpenStack Cinder brick library for managing local volume attaches"
HOMEPAGE="
	https://opendev.org/openstack/os-brick
	https://launchpad.net/os-brick
	https://pypi.org/project/os-brick
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-5.5.1[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.30.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-4.4.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-3.1.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-4.4.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-5.0.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-privsep-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-service-2.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.8.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.25.1[${PYTHON_USEDEP}]
	>=dev-python/tenacity-6.3.1[${PYTHON_USEDEP}]
	>=dev-python/os-win-5.4.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/ddt-1.4.1[${PYTHON_USEDEP}]
		>=dev-python/oslotest-4.4.1[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.5.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.4.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-vmware-3.8.0[${PYTHON_USEDEP}]
		>=dev-python/castellan-3.7.0[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/bandit-1.6.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	sed -i -e 's/\tetc/\t\/etc/g' setup.cfg || die
	distutils-r1_python_prepare_all
}
