# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="A library for glance"
HOMEPAGE="
	https://github.com/openstack/glance_store
	https://opendev.org/openstack/glance_store
	https://pypi.org/project/glance-store
	https://launchpad.net/glance-store
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cinder swift vmware"

RDEPEND="
	>=dev-python/oslo-config-5.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.7.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-3.26.0[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.18.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.11.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/keystoneauth-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/python-keystoneclient-3.8.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.14.2[${PYTHON_USEDEP}]
	cinder? (
		>=dev-python/python-cinderclient-4.1.0[${PYTHON_USEDEP}]
		>=dev-python/os-brick-2.6.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-rootwrap-5.8.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-privsep-1.23.0[${PYTHON_USEDEP}]
	)
	swift? (
		>=dev-python/httplib2-0.9.1[${PYTHON_USEDEP}]
		>=dev-python/python-swiftclient-3.2.0[${PYTHON_USEDEP}]
	)
	vmware? ( >=dev-python/oslo-vmware-3.6.0[${PYTHON_USEDEP}] )
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/requests-mock-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/retrying-1.3.3[${PYTHON_USEDEP}]
		>=dev-python/stestr-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/boto3-1.9.199[${PYTHON_USEDEP}]
	)
"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	test? ( cinder swift vmware )
"

distutils_enable_tests pytest
