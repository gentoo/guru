# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Pickled object field for Django"
HOMEPAGE="
	https://github.com/gintas/django-picklefield
	https://pypi.org/project/django-picklefield/
"
SRC_URI="https://github.com/gintas/django-picklefield/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# TODO: Find out how this is supposed to be run
RESTRICT="test"

RDEPEND="
	dev-python/django[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
