# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 pypi

DESCRIPTION="Python version of NASA DE4xx ephemerides for Astronomical Alamanac"
HOMEPAGE="https://pypi.org/project/jplephem/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
