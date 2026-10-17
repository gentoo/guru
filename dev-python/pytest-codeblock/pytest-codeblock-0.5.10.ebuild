# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Test your documentation code blocks"
HOMEPAGE="https://github.com/barseghyanartur/pytest-codeblock"
SRC_URI="https://github.com/barseghyanartur/pytest-codeblock/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pytest[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/django[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/openai[${PYTHON_USEDEP}]
		dev-python/respx[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( ${PN} pytest-django )
EPYTEST_PLUGIN_LOAD_VIA_ENV=1
distutils_enable_tests pytest

src_prepare() {
	# Tests call `pytest` as well, so let's avoid code coverage altogether
	sed -e '/addopts/,/^]$/d' -i pyproject.toml

	# Having this variable set breaks all Django related tests
	sed -e "/DJANGO_SETTINGS_MODULE/d" -i pyproject.toml

	distutils-r1_src_prepare
}
