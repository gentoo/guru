# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1

DESCRIPTION="The sweeter pytest snapshot plugin"
HOMEPAGE="https://github.com/tophat/syrupy https://pypi.org/project/syrupy"
SRC_URI="https://github.com/tophat/syrupy/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/syrupy-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.md CHANGELOG.md )

RDEPEND="
	dev-python/rich[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/colored[${PYTHON_USEDEP}]
	test? (
		dev-python/invoke[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Seems like the output changed but the tests did not
	tests/integration/test_pytest_extension.py::test_ignores_non_function_nodes
)
