# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYPI_VERIFY_REPO=https://github.com/BratishkaErik/zig-recipe
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Generate package manager recipes from Zig projects"
HOMEPAGE="
	https://github.com/BratishkaErik/zig-recipe
	https://pypi.org/project/zig-recipe/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/jinja2-3.1.6[${PYTHON_USEDEP}]
	>=dev-python/natizon-0.4.7[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.3.0[${PYTHON_USEDEP}]
	>=dev-python/rich-14.0.0[${PYTHON_USEDEP}]
	>=dev-python/semver-3.0.4[${PYTHON_USEDEP}]
	>=dev-python/typer-0.15.0[${PYTHON_USEDEP}]
	>=dev-python/yarl-1.18.0[${PYTHON_USEDEP}]
	|| (
		>=dev-lang/zig-0.17.0
		>=dev-lang/zig-bin-0.17.0
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	epytest -m "not requires_zig"
}
