# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Python multiprocessing fork"
HOMEPAGE="
	https://pypi.org/project/billiard/
	https://github.com/celery/billiard
"
SRC_URI="https://github.com/celery/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? ( dev-python/psutil[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

distutils_enable_sphinx Doc
