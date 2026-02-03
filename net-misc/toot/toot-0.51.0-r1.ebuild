# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="toot - Mastodon CLI & TUI"
HOMEPAGE="https://github.com/ihabunek/toot"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
		dev-python/urwid[${PYTHON_USEDEP}]
		dev-python/wcwidth[${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/tomlkit[${PYTHON_USEDEP}]
		test? ( dev-python/psycopg:2[${PYTHON_USEDEP}] )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-urwid-compat.patch" )

EPYTEST_PLUGINS=( pytest-click python-dateutil pillow )
distutils_enable_tests pytest
