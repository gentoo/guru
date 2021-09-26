# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=bdepend
MY_PN=${PN/-/.}
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Common code for writing OpenStack upgrade checks"
HOMEPAGE="
	https://opendev.org/openstack/oslo.upgradecheck
	https://pypi.org/project/oslo.upgradecheck
"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/oslo-config-5.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
	>=dev-python/prettytable-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-4.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-policy-2.0.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/hacking-3.0[${PYTHON_USEDEP}]
		>=dev-python/oslotest-3.5.0[${PYTHON_USEDEP}]
		>=dev-python/oslo-serialization-2.21.1[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
