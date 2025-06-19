# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
PYTHON_REQ_USE="ncurses"
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature pypi

DESCRIPTION="Command Line Lyrics fetcher for MPRIS media players"
HOMEPAGE="https://github.com/Jugran/lyrics-in-terminal"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

distutils_enable_tests import-check

pkg_postinst() {
	optfeature "MPD player support" dev-python/python-mpd2
}
