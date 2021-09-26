# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="hacking is a set of flake8 plugins that test and enforce the OpenStack StyleGuide"
HOMEPAGE="
	https://github.com/openstack-dev/hacking
	https://pypi.org/project/hacking
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-python/flake8-3.8.0[${PYTHON_USEDEP}]
	<dev-python/flake8-3.9.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/ddt-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/eventlet-0.18.2[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
