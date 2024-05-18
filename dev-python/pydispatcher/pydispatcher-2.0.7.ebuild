# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
PYPI_PN="PyDispatcher"
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Multi-producer-multi-consumer signal dispatching mechanism"
HOMEPAGE="https://github.com/mcfletch/pydispatcher"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest
