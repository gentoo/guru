# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_14 )

inherit distutils-r1

DESCRIPTION="Python3 library for interacting with devices that support a Redfish service"
HOMEPAGE="https://github.com/DMTF/python-redfish-library"
# sdist doesn't include tests
SRC_URI="https://github.com/DMTF/python-redfish-library/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/python-redfish-library-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/jsonpatch[${PYTHON_USEDEP}]
	dev-python/jsonpath-ng[${PYTHON_USEDEP}]
	dev-python/jsonpointer[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]
	dev-python/requests-unixsocket[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
