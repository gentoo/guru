# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1

DESCRIPTION="Personal advice utility for Gentoo package maintainers"
HOMEPAGE="
	https://find-work.sysrq.in/
	https://pypi.org/project/find-work/
"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sysrq.in/${PN}"
else
	inherit pypi
	KEYWORDS="~amd64"
fi

LICENSE="WTFPL-2"
SLOT="0"
IUSE="minimal"

RDEPEND="
	<app-portage/gentoopm-2[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3[${PYTHON_USEDEP}]
	<dev-python/aiohttp-4[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-aliases[${PYTHON_USEDEP}]
	dev-python/deepmerge[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4[${PYTHON_USEDEP}]
	<dev-python/platformdirs-5[${PYTHON_USEDEP}]
	<dev-python/pluggy-2[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2[${PYTHON_USEDEP}]
	<dev-python/pydantic-3[${PYTHON_USEDEP}]
	>=dev-python/requests-2[${PYTHON_USEDEP}]
	<dev-python/requests-3[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-import-check[${PYTHON_USEDEP}]
	)
"

# No ${PYTHON_USEDEP} because plugin deps can lag behind
PDEPEND="
	!minimal? (
		dev-util/find-work-bugzilla
		dev-util/find-work-pkgcheck
		dev-util/find-work-repology
	)
"

EPYTEST_DESELECT=(
	# fails with plug-ins installed
	find_work/__main__.py::import-check
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/insipid-sphinx-theme \
	dev-python/sphinx-prompt
