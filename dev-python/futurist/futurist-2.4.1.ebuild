# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Useful additions to futures, from the future"
HOMEPAGE="
	https://opendev.org/openstack/futurist
	https://pypi.org/project/futurist/
	http://docs.openstack.org/developer/futurist
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/eventlet[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.7.1[${PYTHON_USEDEP}]
		dev-python/stestr[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest
