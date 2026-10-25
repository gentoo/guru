# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_VERIFY_REPO=https://github.com/notatallshaw/nab
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="IO-free resolution core for nab"
HOMEPAGE="
	https://github.com/notatallshaw/nab/
	https://pypi.org/project/nab-provider/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/nab-resolver[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest )

distutils_enable_tests pytest

python_test() {
	# skip test that expects monorepo
	epytest --deselect tests/test_pep508.py::TestParseRequirement::test_over_nested_marker_raises_invalid_requirement \
		--deselect tests/test_pep508.py::TestRequirementParsingIsRouted::test_no_shipped_module_constructs_a_requirement
}
