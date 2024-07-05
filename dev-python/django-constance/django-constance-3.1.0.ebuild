# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Django live settings with pluggable backends, including Redis"
HOMEPAGE="
	https://github.com/jazzband/django-constance
	https://pypi.org/project/django-constance/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

# TODO: Find out how this is supposed to be run
RESTRICT="test"

RDEPEND="
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/django-picklefield[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
