# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="toot - Mastodon CLI & TUI"
HOMEPAGE="https://github.com/ihabunek/toot"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
		>=dev-python/urwid-2.1.2-r1[${PYTHON_USEDEP}]
		>=dev-python/wcwidth-0.2.6[${PYTHON_USEDEP}]
		media-fonts/ttf-ancient-fonts
		>=dev-python/beautifulsoup4-4.12.2[${PYTHON_USEDEP}]
		>=dev-python/tomlkit-0.11.8[${PYTHON_USEDEP}]
		test? ( dev-python/psycopg:2[${PYTHON_USEDEP}]
		>=dev-python/pytest-7.4.0[${PYTHON_USEDEP}] )
"
RDEPEND="${DEPEND}"

distutils_enable_tests pytest
