# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils udev xdg-utils

MY_COMMIT="f5feb4b3d17bbf16171d716bbb8e28f3a84542ef"

DESCRIPTION="It's a flashlight, what do you expect?"
HOMEPAGE="https://gitlab.com/a-wai/flashlight.git"
SRC_URI="https://gitlab.com/a-wai/flashlight/-/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="x11-libs/gtk+"
BDEPEND="dev-lang/python-exec[native-symlinks]"

src_install() {
	meson_src_install
	udev_dorules "${FILESDIR}/60-flashlight.rules"
	mv "${D}/usr/share/appdata" "${D}/usr/share/metainfo" || die
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
