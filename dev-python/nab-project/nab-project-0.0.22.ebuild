# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_VERIFY_REPO=https://github.com/notatallshaw/nab
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Indexed-backed provider, lockfile emitter, and downloader for nab"
HOMEPAGE="
	https://github.com/notatallshaw/nab/
	https://pypi.org/project/nab-project/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/nab-index[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest build httpx2 hypothesis respx )

distutils_enable_tests pytest

src_prepare() {
	rm tests/test_pylock.py || die
	eapply_user
}

python_test() {
	epytest -m "not benchmark" \
		--deselect tests/benchmark/test_benchmark_import_path.py::test_siblings_resolve_to_the_benchmark_scripts
}
