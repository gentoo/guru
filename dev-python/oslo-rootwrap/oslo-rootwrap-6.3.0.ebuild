# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Allows fine filtering of shell commands to run as root from OpenStack services"
HOMEPAGE="
	https://pypi.org/project/oslo.rootwrap
	https://opendev.org/openstack/oslo.rootwrap
	https://launchpad.net/oslo.rootwrap
"
SRC_URI="mirror://pypi/${PN:0:1}/oslo.rootwrap/oslo.rootwrap-${PV}.tar.gz"
S="${WORKDIR}/oslo.rootwrap-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/six-1.10.0[${PYTHON_USEDEP}]"
DEPEND="
	${RDEPEND}
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.18.2[${PYTHON_USEDEP}]
		>=dev-python/reno-3.1.0[${PYTHON_USEDEP}]
		>=dev-python/bandit-1.3.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
