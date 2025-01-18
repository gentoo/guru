# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=meson-python
PYTHON_COMPAT=( python3_{10..13} pypy3 )
inherit distutils-r1 pypi

DESCRIPTION="rime for python"
HOMEPAGE="
	https://github.com/Freed-Wu/pyrime
	https://pypi.org/project/pyrime
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+prompt-toolkit +ptpython"

DEPEND="
	app-i18n/librime
	dev-python/autopxd[${PYTHON_USEDEP}]
"
RDEPEND="
	$DEPEND
	prompt-toolkit? (
		dev-python/prompt-toolkit[${PYTHON_USEDEP}]
		dev-python/platformdirs[${PYTHON_USEDEP}]
	)
	ptpython? (
		dev-python/ptpython[${PYTHON_USEDEP}]
		dev-python/platformdirs[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${P}-fix-meson-project.patch"
)

EPYTEST_XDIST=1
distutils_enable_tests pytest

python_test() {
	epytest
}
