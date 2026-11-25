# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYPI_VERIFY_REPO=https://github.com/BratishkaErik/natizon
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Pure Python, native ZON (Zig Object Notation) parser and serializer"
HOMEPAGE="
	https://github.com/BratishkaErik/natizon
	https://pypi.org/project/natizon/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/lark-1.3.1[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest-codeblocks )
distutils_enable_tests pytest

python_test() {
	epytest -m "not requires_zig"
}
