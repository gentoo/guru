# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="generified reports for openstack"
HOMEPAGE="
	https://opendev.org/openstack/oslo.reports
	https://pypi.org/project/oslo.reports
	https://launchpad.net/oslo.reports
"
SRC_URI="mirror://pypi/${PN:0:1}/oslo.reports/oslo.reports-${PV}.tar.gz"
S="${WORKDIR}/oslo.reports-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.10[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/psutil-3.2.2[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-5.2.0[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.18.2[${PYTHON_USEDEP}]
		>=dev-python/greenlet-0.4.15[${PYTHON_USEDEP}]
		>=dev-python/bandit-1.6.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
