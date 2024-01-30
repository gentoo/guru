# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="ncurses"
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature

DESCRIPTION="Command Line Lyrics fetcher for MPRIS media players"
HOMEPAGE="https://github.com/Jugran/lyrics-in-terminal"
SRC_URI="https://github.com/Jugran/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/dbus-python[${PYTHON_USEDEP}]"

pkg_postinst() {
	optfeature "MPD player support" dev-python/python-mpd2
}
