# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Extensions for JSONPath RW"
HOMEPAGE="
	https://pypi.org/project/jsonpath-rw-ext
	https://github.com/sileht/python-jsonpath-rw-ext
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pbr-1.8[${PYTHON_USEDEP}]
	>=dev-python/jsonpath-rw-1.2.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		>=dev-python/hacking-0.12.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/oslotest-1.10.0[${PYTHON_USEDEP}]
		>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-1.4.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
