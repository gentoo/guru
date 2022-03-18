# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_IGNORE=( oslo_privsep/functional )
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="OpenStack library for privilege separation"
HOMEPAGE="
	https://opendev.org/openstack/oslo.privsep
	https://pypi.org/project/oslo.privsep/
"
SRC_URI="mirror://pypi/${PN:0:1}/oslo.privsep/oslo.privsep-${PV}.tar.gz"
S="${WORKDIR}/oslo.privsep-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-3.36.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-5.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	>=dev-python/cffi-1.14.0[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.21.0[${PYTHON_USEDEP}]
	>=dev-python/greenlet-0.4.14[${PYTHON_USEDEP}]
	>=dev-python/msgpack-0.6.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	# allow usage of renamed msgpack
	sed -i '/^msgpack/d' requirements.txt || die
	distutils-r1_python_prepare_all
}
