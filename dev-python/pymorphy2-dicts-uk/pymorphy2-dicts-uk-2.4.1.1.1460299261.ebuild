# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_10 pypy3  )
DISTUTILS_USE_SETUPTOOLS=bdepend
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Ukrainian dictionary for PyMorphy2"
HOMEPAGE="https://pypi.org/project/pymorphy2-dicts-uk/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
