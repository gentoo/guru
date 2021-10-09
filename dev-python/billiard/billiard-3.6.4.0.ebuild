# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8,9} pypy3 )

inherit distutils-r1

DESCRIPTION="Python multiprocessing fork"
HOMEPAGE="
	https://pypi.org/project/billiard
	https://github.com/celery/billiard
"
SRC_URI="https://github.com/celery/billiard/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="
	test? (
		>=dev-python/case-1.3.1[${PYTHON_USEDEP}]
		>=dev-python/pytest-3.0[${PYTHON_USEDEP}]
		<dev-python/pytest-6.2[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
	)
"
# The usual req'd for tests
DISTUTILS_IN_SOURCE_BUILD=1

distutils_enable_tests pytest
distutils_enable_sphinx Doc
