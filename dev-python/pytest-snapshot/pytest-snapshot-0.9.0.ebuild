# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A plugin for snapshot testing with pytest"
HOMEPAGE="
	https://github.com/joseph-roitman/pytest-snapshot/
	https://pypi.org/project/pytest-snapshot/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pytest-3.0.0[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest-snapshot )
EPYTEST_PLUGIN_LOAD_VIA_ENV=1
distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}"/pytest-snapshot-0.9.0-pytest8.patch
)
