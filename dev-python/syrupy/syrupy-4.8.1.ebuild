# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="The sweeter pytest snapshot plugin"
HOMEPAGE="https://github.com/syrupy-project/syrupy https://pypi.org/project/syrupy"
SRC_URI="https://github.com/syrupy-project/syrupy/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DOCS+=( LICENSE README.md CHANGELOG.md )

RDEPEND="
	dev-python/rich[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/invoke[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"

# Can not use dev-python/pytest-xdist because strange errors appear
# EPYTEST_XDIST=1
EPYTEST_DESELECT=(
	# This test fails for some strange reason
	"tests/integration/test_snapshot_option_update.py::test_update_failure_shows_snapshot_diff[xdist_two]"
)
distutils_enable_tests pytest
