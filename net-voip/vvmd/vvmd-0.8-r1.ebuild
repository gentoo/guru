# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="vvmd is a lower level daemon that retrieves Visual Voicemail"
HOMEPAGE="https://gitlab.com/kop316/vvmd"
SRC_URI="https://gitlab.com/kop316/vvmd/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-libs/glib-2.16:2
	dev-libs/libphonenumber
	>=net-misc/curl-7.70
	net-misc/mobile-broadband-provider-info
	>=net-misc/modemmanager-1.14:=
"
DEPEND="${RDEPEND}"
