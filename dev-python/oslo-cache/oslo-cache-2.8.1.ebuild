# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=bdepend
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

MY_PN=${PN/-/.}

DESCRIPTION="Oslo Caching around dogpile.cache"
HOMEPAGE="
	https://opendev.org/openstack/oslo.cache
	https://pypi.org/project/oslo.cache
	https://github.com/openstack/oslo.cache
"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/dogpile-cache-1.1.2[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-8.1.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-4.2.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.2.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-3.0.1[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/pifpaf-0.10.0[${PYTHON_USEDEP}]
		>=dev-python/pymemcache-3.4.0[${PYTHON_USEDEP}]
		>=dev-python/python-binary-memcached-0.29.0[${PYTHON_USEDEP}]
		>=dev-python/python-memcached-1.56[${PYTHON_USEDEP}]
		>=dev-python/pymongo-3.0.2[${PYTHON_USEDEP}]
		>=dev-python/etcd3gw-0.2.0[${PYTHON_USEDEP}]
	)
"

RESTRICT="test"
PROPERTIES="test_network"

distutils_enable_tests pytest
