# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 optfeature pypi xdg-utils

DESCRIPTION="A simple and powerful dual-screen PDF reader designed for presentations"
HOMEPAGE="
	https://github.com/Cimbali/pympress
	https://pypi.org/project/pympress/
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="vlc"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	dev-python/watchdog[${PYTHON_USEDEP}]
	app-text/poppler
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/gtk+:3
	x11-libs/cairo
	dev-python/pycairo[${PYTHON_USEDEP}]
	x11-libs/gdk-pixbuf
	vlc? ( dev-python/python-vlc[${PYTHON_USEDEP}] )
"
BDEPEND="${RDEPEND}"

src_prepare() {
	default
	# >=python3_13 only works with >dev-python/pygobject-3.51
	# https://github.com/Cimbali/pympress/issues/330
	sed -i 's/ a_widget.props/ list(a_widget.props)/' pympress/builder.py || die
}

pkg_postinst() {
	optfeature "gstreamer support" media-libs/gstreamer

	# QA: update desktop database MIME=
	xdg_desktop_database_update
}

pkg_postrm() {
	# QA: update desktop database MIME=
	xdg_desktop_database_update
}
