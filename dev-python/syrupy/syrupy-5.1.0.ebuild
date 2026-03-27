# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="The sweeter pytest snapshot plugin"
HOMEPAGE="https://github.com/syrupy-project/syrupy https://pypi.org/project/syrupy"
SRC_URI="https://github.com/syrupy-project/syrupy/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DOCS+=( LICENSE README.md CHANGELOG.md )

RDEPEND="
	dev-python/rich[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/invoke[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-xdist )
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# Inject required plugins; autoloading can break (e.g., with pytest-relaxed)
	sed -i 's/\([a-zA-Z0-9_]\+\)\.runpytest(/\1.runpytest("-p", "syrupy", "-p", "xdist", /' \
		tests/integration/test_*.py || die
}
