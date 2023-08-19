# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )
inherit distutils-r1

DESCRIPTION="toot - Mastodon CLI & TUI"
HOMEPAGE="https://github.com/ihabunek/toot"
SRC_URI="https://github.com/ihabunek/toot/archive/refs/tags/${PV}.tar.gz"
S="${WORKDIR}/toot-${PV}"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-python/urwid-2.1.2-r1
>=dev-python/wcwidth-0.2.6
>=media-fonts/symbola-13.00
>=dev-python/beautifulsoup4-4.12.2
>=dev-python/tomlkit-0.11.8"
RDEPEND="${DEPEND}"
BDEPEND=""

distutils_enable_tests pytest
