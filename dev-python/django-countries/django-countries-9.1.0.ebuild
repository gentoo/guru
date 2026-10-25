# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
DISTUTILS_USE_PEP517=uv-build

inherit distutils-r1 pypi

DESCRIPTION="Django application for country selection"
HOMEPAGE="
	https://github.com/SmileyChris/django-countries
	https://pypi.org/project/django-countries/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/asgiref[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"

# TODO
RESTRICT="test"
