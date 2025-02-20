# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} pypy3 )

inherit distutils-r1

DESCRIPTION="Accurate Hijri-Gregorian date converter based on the Umm al-Qura calendar"
HOMEPAGE="https://github.com/dralshehri/hijridate"
SRC_URI="https://github.com/dralshehri/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-python/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/furo \
	dev-python/myst-parser \
	dev-python/sphinx-notfound-page
