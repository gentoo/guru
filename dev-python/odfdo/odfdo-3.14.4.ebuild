# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1

DESCRIPTION="Python library for OpenDocument format (ODF)"
HOMEPAGE="
	https://github.com/jdum/odfdo
	https://pypi.org/project/odfdo/
"
SRC_URI="https://github.com/jdum/odfdo/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/lxml-5.3.0[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

# No need to test performance downstream
EPYTEST_DESELECT=( tests/test_performance.py::test_all_perf )
