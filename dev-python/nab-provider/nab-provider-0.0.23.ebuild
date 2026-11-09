# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_VERIFY_REPO=https://github.com/notatallshaw/nab
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{13..15} )

inherit distutils-r1 pypi

DESCRIPTION="IO-free resolution core for nab"
HOMEPAGE="
	https://github.com/notatallshaw/nab/
	https://pypi.org/project/nab-provider/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	~dev-python/nab-markersets-0.0.23[${PYTHON_USEDEP}]
	~dev-python/nab-resolver-0.0.23[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( hypothesis )

distutils_enable_tests pytest

python_test() {
	# skip test that expects monorepo
	local EPYTEST_DESELECT=(
		tests/test_pep508.py::TestParseRequirement::test_over_nested_marker_raises_invalid_requirement
		tests/test_pep508.py::TestRequirementParsingIsRouted::test_no_shipped_module_constructs_a_requirement
	)

	epytest
}
