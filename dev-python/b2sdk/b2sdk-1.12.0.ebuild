# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="The client library for BackBlaze's B2 product"
HOMEPAGE="https://github.com/Backblaze/b2-sdk-python"
SRC_URI="https://github.com/Backblaze/b2-sdk-python/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}/${PN}-1.8.0-disable-requirement-installation.patch"
)

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/arrow-0.8.0[${PYTHON_USEDEP}]
		>=dev-python/logfury-0.1.2[${PYTHON_USEDEP}]
		>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4.5.0[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/importlib_metadata[${PYTHON_USEDEP}]
		' pypy3 python3_7)
"

distutils_enable_tests pytest

BDEPEND+=" test? (
	$(python_gen_cond_dep '
		>=dev-python/pytest-mock-3.3.1[${PYTHON_USEDEP}]
		dev-python/pytest-lazy-fixture[${PYTHON_USEDEP}]
	')
)"

# These tests seem to require some b2 authentication (they're integration tests
# so this is not unreasonable)
python_test() {
	epytest \
		--deselect test/integration/test_large_files.py::TestLargeFile::test_large_file \
		--deselect test/integration/test_raw_api.py::test_raw_api
}
