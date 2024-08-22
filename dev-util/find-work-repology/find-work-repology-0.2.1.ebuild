# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
DISTUTILS_USE_PEP517=flit
inherit distutils-r1 pypi

DESCRIPTION="Personal advice utility for Gentoo package maintainers: Repology plugin"
HOMEPAGE="
	https://find-work.sysrq.in/
	https://pypi.org/project/find-work-repology/
"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<app-portage/gentoopm-2[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-aliases[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2[${PYTHON_USEDEP}]
	<dev-python/pydantic-3[${PYTHON_USEDEP}]
	>=dev-python/repology-client-0.0.2[${PYTHON_USEDEP}]
	<dev-python/repology-client-2[${PYTHON_USEDEP}]
	dev-python/sortedcontainers[${PYTHON_USEDEP}]
	>=dev-util/find-work-0.91[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-import-check[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	cd "${BUILD_DIR}/install$(python_get_sitedir)" || die
	distutils_write_namespace find_work
	epytest "${S}"
}
