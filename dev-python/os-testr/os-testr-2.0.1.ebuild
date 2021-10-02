# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A testr wrapper to provide functionality for OpenStack projects"
HOMEPAGE="
	https://opendev.org/openstack/os-testr
	https://pypi.org/project/os-testr
	https://launchpad.net/os-testr
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/os-testr-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/stestr-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/ddt-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
