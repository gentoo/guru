# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_10 python3_11 python3_12 )
inherit distutils-r1

DESCRIPTION="The client library for BackBlaze's B2 product"
HOMEPAGE="https://github.com/Backblaze/b2-sdk-python"
SRC_URI="https://github.com/Backblaze/b2-sdk-python/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=(
	"${FILESDIR}/${PN}-1.17.2-disable-requirement-installation.patch"
)

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/logfury-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
		>=dev-python/tqdm-4.5.0[${PYTHON_USEDEP}]
	')
"

distutils_enable_tests pytest

BDEPEND+=" test? (
	$(python_gen_cond_dep '
		>=dev-python/pytest-mock-3.6.1[${PYTHON_USEDEP}]
		>=dev-python/pytest-lazy-fixture-0.6.3[${PYTHON_USEDEP}]
	')
)"

EPYTEST_DESELECT=(
	test/integration/test_large_files.py::TestLargeFile::test_large_file
	test/integration/test_raw_api.py::test_raw_api
	test/integration/test_download.py
	test/integration/test_upload.py
	test/unit/account_info/test_sqlite_account_info.py
)
