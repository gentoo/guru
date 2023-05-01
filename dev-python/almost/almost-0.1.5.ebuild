# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

COMMIT="cc3eeb0abde7ff95a222d571443989c74a112ff7"
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1

DESCRIPTION="A helper for approximate comparison"
HOMEPAGE="
	https://github.com/sublee/almost
	https://pypi.org/project/almost/
"
SRC_URI="https://github.com/sublee/almost/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

RESTRICT="!test? ( test )"
PATCHES=( "${FILESDIR}/${P}-setuptools.patch" )

distutils_enable_tests setup.py
