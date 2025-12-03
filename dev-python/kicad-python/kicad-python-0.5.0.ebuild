# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..14} )
inherit distutils-r1 pypi

DESCRIPTION="KiCad API Python Bindings for interacting with running KiCad sessions"
HOMEPAGE="https://gitlab.com/kicad/code/kicad-python https://pypi.org/project/kicad-python"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"

# Tests not included in PyPI sdist
RESTRICT="test"

RDEPEND="
	>=dev-python/protobuf-5.29[${PYTHON_USEDEP}]
	<dev-python/protobuf-6[${PYTHON_USEDEP}]
	>=dev-python/pynng-0.8.0[${PYTHON_USEDEP}]
	<dev-python/pynng-0.9.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/typing-extensions-4.13.2[${PYTHON_USEDEP}]
	' python3_{10..12})
"
BDEPEND="${RDEPEND}"

src_prepare() {
	# Remove build script config from pyproject.toml
	# The sdist already contains pre-generated protobuf files
	sed -i '/\[tool.poetry.build\]/,/^$/d' pyproject.toml || die
	rm -f setup.py build.py || die
	distutils-r1_src_prepare
}
