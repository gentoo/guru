# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

COMMIT="a7ca6ce9d4c947f19c3f99ff2cab986c64434e57"

DESCRIPTION="Call audio routing daemon"
HOMEPAGE="https://gitlab.com/mobian1/callaudiod"
SRC_URI="https://gitlab.com/mobian1/${PN}/-/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

KEYWORDS="~amd64 ~arm64"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-libs/glib:2
	dev-util/gdbus-codegen
	media-libs/alsa-lib
	|| (
		media-libs/libpulse
		>=media-sound/apulse-0.1.12-r4[sdk]
	)
"

BUILD_DIR="${S}"/build
