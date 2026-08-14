# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="AutoKey, a desktop automation utility for Linux and X11."
HOMEPAGE="
	https://github.com/autokey/autokey
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="+gtk qt5"

RDEPEND="dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/python-xlib[${PYTHON_USEDEP}]
	dev-python/pyhamcrest[${PYTHON_USEDEP}]
	dev-python/python-magic
	media-gfx/imagemagick
	x11-misc/xautomation
	x11-misc/wmctrl
	gtk? (
		dev-python/pygobject[${PYTHON_USEDEP}]
		gnome-extra/zenity
		dev-libs/libayatana-appindicator
		x11-libs/gtksourceview:3.0
	)
	qt5? (
		dev-python/pyqt5[${PYTHON_USEDEP}]
		dev-python/qscintilla[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	test? (
		>=dev-python/pyhamcrest-2.1.0[${PYTHON_USEDEP}]
		dev-python/coverage
	)
"

src_compile() {
	eapply "${FILESDIR}"/0001-scripting-Remove-dependency-on-imghdr.patch

	if ! use qt5; then
		rm --verbose --force --recursive "${S}/lib/autokey/qtui"
		rm --verbose --force --recursive "${S}/lib/autokey/qtapp.py"
		rm --verbose --force --recursive "${S}/lib/autokey/scripting/clipboard_qt.py"
		rm --verbose --force --recursive "${S}/lib/autokey/scripting/dialog_qt.py"
		rm --verbose --force --recursive "${S}/config/autokey-qt.desktop"
		rm --verbose --force --recursive "${S}/doc/man/autokey-qt.1"
		if use gtk; then
			eapply "${FILESDIR}"/noqt.patch
		fi
	fi

	if ! use gtk; then
		rm --verbose --force --recursive "${S}/lib/autokey/gtkui"
		rm --verbose --force --recursive "${S}/lib/autokey/gtkapp.py"
		rm --verbose --force --recursive "${S}/lib/autokey/scripting/clipboard_gtk.py"
		rm --verbose --force --recursive "${S}/lib/autokey/scripting/dialog_gtk.py"
		rm --verbose --force --recursive "${S}/config/autokey-gtk.desktop"
		rm --verbose --force --recursive "${S}/doc/man/autokey-gtk.1"
		if ! use qt5; then
			eapply "${FILESDIR}"/noqt-nogtk.patch
		else
			eapply "${FILESDIR}"/nogtk.patch
		fi
	fi
	distutils-r1_src_compile
}

EPYTEST_PLUGINS=( pytest-cov )

distutils_enable_tests pytest
