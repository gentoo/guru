# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=bdepend
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A middleware for the OpenStack Keystone API"
HOMEPAGE="
	https://github.com/openstack/keystonemiddleware
	https://opendev.org/openstack/keystonemiddleware
	https://launchpad.net/keystonemiddleware
	https://pypi.org/project/keystonemiddleware
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/keystoneauth-3.12.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-cache-1.26.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-5.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-2.19.2[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-3.36.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-1.18.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.33.0[${PYTHON_USEDEP}]
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pycadf-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-keystoneclient-3.20.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.14.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/webob-1.7.1[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/hacking-3.0[${PYTHON_USEDEP}]
		>=dev-python/cryptography-3.0[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/requests-mock-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/stevedore-1.20.0[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testresources-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/python-memcached-1.59[${PYTHON_USEDEP}]
		>=dev-python/webtest-2.0.27[${PYTHON_USEDEP}]
		>=dev-python/oslo-messaging-5.29.0[${PYTHON_USEDEP}]
		>=dev-python/bandit-1.1.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
