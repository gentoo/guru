# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=bdepend
PYTHON_COMPAT=( python3_8 )

inherit distutils-r1

DESCRIPTION="Support for RBAC policy enforcement across all OpenStack services"
HOMEPAGE="
	https://opendev.org/openstack/oslo.policy
	https://pypi.org/project/oslo.policy
	https://github.com/openstack/oslo.policy
"
SRC_URI="mirror://pypi/${PN:0:1}/oslo.policy/oslo.policy-${PV}.tar.gz"
S="${WORKDIR}/oslo.policy-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-python/requests-2.14.2[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-i18n-3.15.3[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-1.18.0[${PYTHON_USEDEP}]
	!~dev-python/oslo-serialization-1.19.1[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.20.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.40.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/pbr-2.0.0[${PYTHON_USEDEP}]
	test? (
		>=dev-python/oslotest-3.2.0[${PYTHON_USEDEP}]
		>=dev-python/requests-mock-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/sphinx-2.0.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
