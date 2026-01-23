# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 meson udev

DESCRIPTION="Steering Wheel Manager for Linux"
HOMEPAGE="https://github.com/berarma/oversteer"
SRC_URI="https://github.com/berarma/oversteer/archive/v${PV}.tar.gz -> oversteer-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/pyudev[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/evdev[${PYTHON_USEDEP}]
	sys-devel/gettext
	dev-libs/appstream-glib
	dev-python/matplotlib[gtk3,${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
	    -Dpython.bytecompile=2
	)
	meson_src_configure
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
