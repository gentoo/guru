# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Library to build command line interfaces based on Click"
HOMEPAGE="
	https://github.com/janLuke/cloup
	https://pypi.org/project/cloup/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.rst CREDITS.rst examples )

RDEPEND="
	>=dev-python/click-8.1.0[${PYTHON_USEDEP}]
	<dev-python/click-9[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/furo \
	dev-python/sphinx-autoapi \
	dev-python/sphinx-copybutton \
	dev-python/sphinx-issues \
	dev-python/sphinx-panels

python_prepare_all() {
	# Avoid unnecessary and unpackaged sphinx-version-warning
	sed '/versionwarning.extension/d' -i docs/conf.py || die
	distutils-r1_python_prepare_all
}
