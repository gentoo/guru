# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_VERIFY_REPO=https://github.com/notatallshaw/nab
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Generic PubGrub dependency-resolver core"
HOMEPAGE="
	https://github.com/notatallshaw/nab/
	https://pypi.org/project/nab-resolver/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest pytest-timeout hypothesis )

distutils_enable_tests pytest

src_prepare() {
	# skit test that expects monorepo
	rm tests/property/test_crosshair_ranges.py

	eapply_user
}

python_test() {
	epytest -m "not benchmark"
}
