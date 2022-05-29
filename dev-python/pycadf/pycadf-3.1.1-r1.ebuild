# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=bdepend
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="python implementation of DMTF Cloud Audit (CADF) data model"
HOMEPAGE="
	https://opendev.org/openstack/pycadf
	https://pypi.org/project/pycadf/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-1.8.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-5.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-2.18.0[${PYTHON_USEDEP}]
	>=dev-python/pytz-2013.6[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/debtcollector-1.2.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
