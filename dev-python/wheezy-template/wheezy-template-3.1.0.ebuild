# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Tests aren't passing with PEP517
#DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1

MY_PN="wheezy.template"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="lightweight template library"
HOMEPAGE="https://github.com/akornatskyy/wheezy.template"
# as usual pypi doesn't contains tests
SRC_URI="https://github.com/akornatskyy/wheezy.template/archive/refs/tags/${PV}.tar.gz -> ${MY_P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"
KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

DEPEND="dev-python/cython[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
