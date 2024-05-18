# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1

DESCRIPTION="A robust and significantly extended implementation of JSONPath for Python"
HOMEPAGE="
	https://github.com/kennknowles/python-jsonpath-rw
	https://pypi.org/project/jsonpath-rw/
"
SRC_URI="https://github.com/kennknowles/python-jsonpath-rw/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/python-${P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

distutils_enable_tests unittest
