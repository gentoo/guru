# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="a development sdk for managing z/VM"
HOMEPAGE="
	https://github.com/mfcloud/python-zvm-sdk
	https://pypi.org/project/zVMCloudConnector/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/jsonschema-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.5[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/routes-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/webob-1.2.3[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/mock-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-1.6.2[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
