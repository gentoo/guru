# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="A simple parser for OpenStack microversion headers"
HOMEPAGE="
	https://opendev.org/openstack/microversion-parse
	https://github.com/openstack/microversion-parse
"
SRC_URI="mirror://pypi/${PN:0:1}/microversion_parse/microversion_parse-${PV}.tar.gz"
S="${WORKDIR}/microversion_parse-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/pbr-5.0[${PYTHON_USEDEP}]
	>=dev-python/webob-1.2.3[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND="
	test? (
		>=dev-python/testtools-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/gabbi-1.35.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
