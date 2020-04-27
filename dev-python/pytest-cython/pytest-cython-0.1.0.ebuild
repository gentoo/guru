# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1
DISTUTILS_USE_SETUPTOOLS=rdepend

DESCRIPTION="Plugin for testing Cython extension modules"
HOMEPAGE="https://github.com/lgpage/pytest-cython"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"
#IUSE="test"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"
#DEPEND="
#	${RDEPEND}
#	test? (
#		dev-python/check-manifest[${PYTHON_USEDEP}]
#		dev-python/docutils[${PYTHON_USEDEP}]
#		dev-python/pygments[${PYTHON_USEDEP}]
#		dev-python/readme_renderer[${PYTHON_USEDEP}]
#	)
#"

#distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-py3doc-enhanced-theme
