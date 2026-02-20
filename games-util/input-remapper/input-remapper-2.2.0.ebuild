# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Note: 2.2.0 has Python 3.14 support (https://github.com/sezanzeb/input-remapper/pull/1184)
# however not all dependencies have ebuilds with 3.14 support yet. (dev-python/pydbus-0.6.0-r1)
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 systemd udev desktop

DESCRIPTION="A tool to change and program the mapping of your input device buttons"
HOMEPAGE="https://github.com/sezanzeb/input-remapper"
SRC_URI="https://github.com/sezanzeb/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/remove-non-python-files-from-setup.patch"
	"${FILESDIR}/fix-translations.patch"
)

RDEPEND="
	x11-libs/gtk+:3
	x11-libs/gtksourceview
	x11-apps/xmodmap
	$(python_gen_cond_dep '
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/pydbus[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		>=dev-python/evdev-1.3.0[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]
	')
	virtual/udev
"

EPYTEST_PLUGINS=()

distutils_enable_tests pytest

src_install() {
	# Install data files
	insinto /usr/share/input-remapper/
	doins -r "${S}"/data/*

	# Install lang files
	insinto /usr/share/input-remapper/lang
	doins -r "${S}"/mo/*

	# Install udev rules
	udev_dorules data/99-input-remapper.rules

	# Install systemd service
	systemd_dounit data/input-remapper.service

	# Install desktop file
	domenu data/input-remapper-gtk.desktop

	# Install icon file
	doicon -s scalable data/input-remapper.svg

	# Install audoload file
	insinto /etc/xdg/autostart
	newins data/input-remapper-autoload.desktop input-remapper-autoload.desktop

	# Install dbus config
	insinto /usr/share/dbus-1/system.d
	newins data/inputremapper.Control.conf inputremapper.Control.conf

	# Install polkit policy
	insinto /usr/share/polkit-1/actions
	newins data/input-remapper.policy input-remapper.policy

	# Install metainfo
	insinto /usr/share/metainfo
	newins data/io.github.sezanzeb.input_remapper.metainfo.xml io.github.sezanzeb.input_remapper.metainfo.xml

	# Install bin files
	exeinto /usr/bin
	newexe bin/input-remapper-gtk input-remapper-gtk
	newexe bin/input-remapper-service input-remapper-service
	newexe bin/input-remapper-control input-remapper-control
	newexe bin/input-remapper-reader-service input-remapper-reader-service

	# Install python site-packages files
	distutils-r1_src_install
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
