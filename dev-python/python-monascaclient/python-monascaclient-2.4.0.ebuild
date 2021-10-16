# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Monasca API"
HOMEPAGE="
	https://github.com/openstack/python-monascaclient
	https://opendev.org/openstack/python-octaviaclient
	https://pypi.org/project/python-octaviaclient
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/osc-lib-1.8.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-1.18.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	>=dev-python/Babel-2.3.4[${PYTHON_USEDEP}]
	>=dev-python/iso8601-0.1.11[${PYTHON_USEDEP}]
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/prettytable-0.7.2[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.12.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/bandit-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
