# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit meson udev git-r3

DESCRIPTION="Steering Wheel Manager for Linux"
HOMEPAGE="https://github.com/berarma/oversteer"
EGIT_REPO_URI="https://github.com/berarma/oversteer.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

BDEPEND="
	dev-python/pygobject
	dev-python/pyudev
	dev-python/pyxdg
	dev-python/evdev
	sys-devel/gettext
	dev-libs/appstream-glib
	dev-python/matplotlib[gtk3]
	dev-python/scipy
"
DEPEND="${BDEPEND}"

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
