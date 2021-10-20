# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_IGNORE=( aodhclient/tests/functional )
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Aodh API"
HOMEPAGE="
	https://github.com/openstack/python-aodhclient
	https://opendev.org/openstack/python-aodhclient
	https://pypi.org/project/aodhclient
	https://launchpad.net/python-aodhclient
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-1.4[${PYTHON_USEDEP}]
	>=dev-python/cliff-1.14.0[${PYTHON_USEDEP}]
	>=dev-python/osc-lib-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/osprofiler-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth-1.0.0[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-3.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-1.10.0[${PYTHON_USEDEP}]
		>=dev-python/reno-1.6.2[${PYTHON_USEDEP}]
		>=dev-python/tempest-10[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/pifpaf-0.23[${PYTHON_USEDEP}]
		dev-python/gnocchi[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
