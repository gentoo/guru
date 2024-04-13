# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="This module simplifies creation of data classes (PEP 557) from dictionaries"
HOMEPAGE="https://github.com/konradhalas/dacite"
SRC_URI="https://github.com/konradhalas/dacite/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"

DEPEND="
	test? ( dev-python/pytest-benchmark )
"

distutils_enable_tests pytest
