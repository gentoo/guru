# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Python library to easily setup basic logging functionality"
HOMEPAGE="
	https://pypi.org/project/daiquiri/
	https://github.com/jd/daiquiri
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/python-json-logger[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
