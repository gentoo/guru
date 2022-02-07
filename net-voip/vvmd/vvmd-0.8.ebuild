# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson systemd udev

DESCRIPTION="vvmd is a lower level daemon that retrieves Visual Voicemail"
HOMEPAGE="https://gitlab.com/kop316/vvmd"
SRC_URI="https://gitlab.com/kop316/vvmd/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-libs/glib-2.16
	>=net-misc/curl-7.70
	>=dev-cpp/glibmm-1.14
	dev-libs/libphonenumber
"

DEPEND=""

src_install() {
	meson_src_install
}
