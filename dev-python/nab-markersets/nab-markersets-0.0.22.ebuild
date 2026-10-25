# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_VERIFY_REPO=https://github.com/notatallshaw/nab
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="PEP 508 marker algebra, markers as sets of environments"
HOMEPAGE="
	https://github.com/notatallshaw/nab/
	https://pypi.org/project/nab-markersets/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest )

distutils_enable_tests pytest

python_test() {
	# skip tests that expect monorepo
	local EPYTEST_DESELECT=(
		tests/test_fetch_port.py::TestPortDeclaration::test_declares_exactly_the_members_its_consumers_use
		tests/test_lockfile.py::TestGettingStartedTranscript::test_documented_pins_render_as_written
		tests/test_toml_io.py::TestCensus::test_census_reads_the_wrapper_itself
		tests/test_toml_io.py::TestCensus::test_every_parse_goes_through_toml_io
	)

	epytest -m 'not benchmark'
}
