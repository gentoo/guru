# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_VERIFY_REPO=https://github.com/notatallshaw/nab
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Pypi Simple-API client and on-disk cache for nab"
HOMEPAGE="
	https://github.com/notatallshaw/nab/
	https://pypi.org/project/nab-index/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/nab-provider[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest )

distutils_enable_tests pytest

python_test() {
	# skip tests that expect monorepo
	local EPYTEST_DESELECT=(
		tests/test_index_parsed_cache.py::TestReadPathRebuild::test_over_nested_blob_warns_and_reparses
		tests/test_parsed_listing_codec.py::test_over_nested_blob_is_miss
		tests/test_parsed_listing_codec.py::test_over_nested_blob_names_its_depth
		tests/test_read_fresh_parsed_listing.py::TestReadFreshParsedListing::test_over_nested_policy_returns_none
		tests/test_read_fresh_parsed_listing.py::TestReadFreshParsedListing::test_over_nested_blob_returns_none
	)

	epytest
}
